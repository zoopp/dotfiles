#!/usr/bin/env python

import re
import os
import argparse

from typing import List
from pathlib import Path


_ASOUND_PATH = Path('/proc/asound')
_DAEMON_CONF_PATH = Path('~/.config/pulse/daemon.conf').expanduser()


def _get_card_names() -> List[str]:
    card_dirs = [path for path in _ASOUND_PATH.glob('card[0-9]*')]

    card_names = []
    for card_dir in card_dirs:
        with (card_dir / 'id').open() as f:
            card_names.append(f.readline().strip())
    return card_names


def _get_sample_rates() -> List[int]:
    with (_ASOUND_PATH / 'K3' / 'stream0').open() as file:
        file_contents = file.read()

    rates_lines = re.findall(r'Rates: (.+)', file_contents)
    rates = sorted({
        int(rate)
        for line in rates_lines
        for rate in line.split(',')
    }, reverse=True)
    return rates


def _get_rates_command(_):
    print('\n'.join(str(rate) for rate in _get_sample_rates()))


def _set_rates_command(args):
    with _DAEMON_CONF_PATH.open() as file:
        file_contents = file.read()

    file_contents = re.sub(
        r'^\s*default-sample-rate\s*=\s*\d+$',
        f'default-sample-rate = {args.rate}',
        file_contents, flags=re.MULTILINE
    )
    file_contents = re.sub(
        r'^\s*alternate-sample-rate\s*=\s*\d+$',
        f'alternate-sample-rate = {args.rate}',
        file_contents, flags=re.MULTILINE
    )

    with _DAEMON_CONF_PATH.open('w') as file:
        file.write(file_contents)

    os.system('pulseaudio -k')


def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(title='commands',
                                       dest='command')
    subparsers.required = True

    get_rates_parser = subparsers.add_parser('get-rates')
    get_rates_parser.set_defaults(func=_get_rates_command)

    set_rates_parser = subparsers.add_parser('set-rate')
    set_rates_parser.set_defaults(func=_set_rates_command)
    set_rates_parser.add_argument('rate',
                                  type=int,
                                  choices=_get_sample_rates())

    args = parser.parse_args()
    args.func(args)


if __name__ == '__main__':
    main()

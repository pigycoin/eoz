#!/usr/bin/env bash
#
# Copyright (c) 2018 The Eozi Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Check that all RPC help texts are generated by RPCHelpMan.

export LC_ALL=C

EXIT_CODE=0

# Assume that all multiline strings passed into a runtime_error are help texts.
# This is potentially fragile, but the linter is only temporary and can safely
# be removed early 2019.

non_autogenerated_help=$(grep --perl-regexp --null-data --only-matching 'runtime_error\(\n\s*".*\\n"\n' $(git ls-files -- "*.cpp"))
if [[ ${non_autogenerated_help} != "" ]]; then
    echo "Must use RPCHelpMan to generate the help for the following RPC methods:"
    echo "${non_autogenerated_help}"
    echo
    EXIT_CODE=1
fi
exit ${EXIT_CODE}

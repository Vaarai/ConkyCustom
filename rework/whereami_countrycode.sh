#!/bin/bash

whereami -r | sed -n 's/^.*"country_code": "\([^"]*\)",*$/\1/p'
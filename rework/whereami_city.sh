#!/bin/bash

whereami -r | sed -n 's/^.*"city": "\([^"]*\)",*$/\1/p'
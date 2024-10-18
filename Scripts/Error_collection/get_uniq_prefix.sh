#!/bin/bash

sed 's/_'$1'.*//' $2 |sort | uniq

#!/bin/bash

activate() {
        source django/bin/activate
        pip install django
}

activate

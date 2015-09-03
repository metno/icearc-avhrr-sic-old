from behave import *
import yaml
import os

def before_all(context):
    context.ansible_basedir = os.path.join(os.path.curdir, 'ansible')
    context.playbook_path = os.path.join(context.ansible_basedir, 'playbook.yml')
    with open(context.playbook_path) as playbook:
        playbook = playbook.read()
    context.playbook = yaml.safe_load(playbook)

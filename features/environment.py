from behave import *
import yaml
import os
from dateutil import parser as dateutil_parser



def before_all(context):
    context.ansible_basedir = os.path.join(os.path.curdir, 'ansible')
    context.playbook_path = os.path.join(context.ansible_basedir, 'playbook.yml')
    with open(context.playbook_path) as playbook:
        playbook = playbook.read()
    context.playbook = yaml.safe_load(playbook)
    context.test_date_string = context.playbook[0]['vars']['test_date']
    context.data_dir = os.path.abspath(os.path.join(os.path.abspath(__file__), os.path.pardir, 'data'))
    context.local_gac_dir = os.path.join(context.data_dir, 'gac')
    context.local_sic_dir = os.path.join(context.data_dir, 'sic')
    context.test_date = dateutil_parser.parse(context.test_date_string)

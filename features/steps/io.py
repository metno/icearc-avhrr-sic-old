from behave import *
import os
import yaml


@given(u'the project deployed using Ansible')
def step_impl(context):
    # check there is an Ansible directory
    assert context.ansible_basedir
    assert context.playbook_path


@then(u'there should be a playbook sitting in the Ansible directory')
def step_impl(context):
    # Check there is a readable playbook in the Ansible directory
    assert context.playbook[0]['vars']['gac_dir']


@when(u'data storage is avaiable')
def step_impl(context):
    assert context.ansible_basedir
    assert context.playbook
    context.data_dir = context.playbook[0]['vars']['gac_dir']
    assert os.path.exists(context.data_dir)


@then(u'it contains NOAA GAC satellite data')
def step_impl(context):
    year = "2008"
    date = "20080710"
    data_dir = os.path.join(context.data_dir, year, date)
    assert os.path.exists(data_dir)
    assert os.listdir(data_dir)

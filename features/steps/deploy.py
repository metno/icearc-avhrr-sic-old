from behave import *


@given(u'the project deployed using Ansible')
def step_impl(context):
    # check there is an Ansible directory one level up
    raise NotImplementedError(u'STEP: Given the project deployed using Ansible')

@then(u'there should be a playbook sitting in the Ansible directory')
def step_impl(context):
    # Check there is a readable playbook in the Ansible directory
    raise NotImplementedError(u'STEP: Then there should be a playbook sitting in the Ansible directory')

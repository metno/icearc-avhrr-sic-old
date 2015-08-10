Feature: Check deployment went successfully

    @wip
    Scenario: ansible stuff exists and can be read

        Given the project deployed using Ansible
        Then there should be a playbook sitting in the Ansible directory

    @wip
    Scenario: NOAA GAC data is available

        When data storage is avaiable
        Then it contains NOAA GAC satellite data

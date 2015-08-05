Feature: Check deployment went successfully

    @wip
    Scenario: As a developer I want to make sure the playbook used for
              deploying my project exists and can be read

        Given the project deployed using Ansible
        Then there should be a playbook sitting in the Ansible directory

    @wip
    Scenario: As a developer I need to make sure
              NOAA AVHRR GAC data available for reading

        When deploying processing environment using Ansible
        Then it contains the data storage contains NOAA AVHRR GAC data

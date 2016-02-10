Feature: Check deployment went successfully

    Scenario: ansible stuff exists and can be read

        Given the project deployed using Ansible
        Then there should be a playbook sitting in the Ansible directory

    Scenario: NOAA GAC data is available

        When data storage is avaiable
        Then it contains NOAA GAC satellite data
        Then the AVHRR data can be read using pypps_reader

    @wip
    Scenario: OSI SAF sea ice data is accessible
        Given the playbook contains SIC data path and is not empty
        Then the OSI SAF data can be read

$(ssh-add ~/.ssh/vagrant)

deploy-vis: ; ansible-playbook -i ansible/hosts ansible/playbook.yml --skip-tags=apt --limit=vism2

deploy-vagrant: ; ansible-playbook -i ansible/hosts ansible/playbook.yml --limit=vagrant --skip-tags=apt --tags=git

deploy-local: ; ansible-playbook -i ansible/hosts ansible/playbook.yml --limit=local --skip-tags=apt

unittest: ; nosetests

behave: ; behave

wip: ; behave --tags=wip

test: ; unittest behave

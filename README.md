# Benchmarkd for redmine_full_text_search

## Install

### Install Terraform

See https://www.terraform.io/intro/getting-started/install.html

### Install ansible

See http://docs.ansible.com/ansible/latest/intro_installation.html

### Setup Terraform

```
$ terraform init Terraform/
```

## Create instances

### Run terraform

```
$ terraform apply Terraform/
```

### Prepare for provisioning

Generate SSH key pair at first time.

```
$ gcloud compute --project "YOUR PROJECT" ssh --zone "YOUR ZONE" "fluentd" --command "echo"
$ gcloud compute --project "YOUR PROJECT" ssh --zone "YOUR ZONE" "redmine-mariadb" --command "echo"
$ gcloud compute --project "YOUR PROJECT" ssh --zone "YOUR ZONE" "redmine-mroonga" --command "echo"
$ gcloud compute --project "YOUR PROJECT" ssh --zone "YOUR ZONE" "redmine-postgresql" --command "echo"
$ gcloud compute --project "YOUR PROJECT" ssh --zone "YOUR ZONE" "redmine-pgroonga" --command "echo"
```

Create ansible/ansible.cfg

```
[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no -o UserKnownHostsFile=~/.ssh/google_compute_known_hosts
```

### Provision

Generate inventory file for ansible and run ansible-playbook command.
Prepare DB dump files before run following commands.

* `ansible/roles/mariadb/files/benchmark-mariadb.dump.sql.xz`
* `ansible/roles/postgresql/files/benchmark-postgresql.dump.sql.xz`

```
$ ./generate-hosts.rb
$ cd ansible
$ ansible-playbook -i hosts playbook.yml
```

## Run benchmark

```
$ gcloud compute --project "YOUR PROJECT" ssh --zone "YOUR ZONE" "fluentd" \
  --command "cd redmine_full_text_search-benchmark/benchmark; ./run.sh"
```

## Benchmark result

Benchmark result is on fluentd host.

```
$ gcloud compute --project "YOUR PROJECT" ssh --zone "YOUR ZONE" "fluentd" \
  --command "sudo -u postgres pg_dump redmine_performance_log" > benchmark-dump.sql
```

And then import dump and analyze your own method.


# Warehouse
v0

---
# Warehouse
A place for all your....host? groups? variables? ips? hostnames? database primaries? endpoints?

---
# Warehouse
v0 - a place for your hosts

--
# Warehouse RFC
This RFC aims to enable programmatic read access to the existing inventory system.

goto/warehouse-rfc

---

# A nod to the past
Inventory management systems @ Squarespace

---

- Atlas
- Kirby
- Glue
- Glue v2
- Ansible
- Ansible Tower
- Terraform Service
- another thing called Warehouse?
- etc

---
# v0 Warehouse
Why will Warehouse succeed?

---
# Product development approach
Small MVP, get users, expand feature set only when and where needed

---
> "...the perspective taken by the SRE Compute team as we tackle this problem space is that deliberate progress through a series of small RFCs and implementations to an inventory system that works for all of Squarespace Infrastructure"

---
# Small Implementation
Keep it simple, don't do too much in one chunk

---
# Get users, get user feedback
Find and get uses cases for clients. Keep talking to them as we build.

---
# Inventory Interface
API = Application Programing Interface

---
# Inventory Interface
Warehouse is not coupled to the current inventory schema

---
# Provisioning Ownership
SRE Datacenter recently combined with SRE Compute

---
# Provisioning Ownership
Provisioning from receiving of hardware at DC to provisioning of a base VM is under one team.

---
# Provisioning Ownership
This allows Compute to provide an Inventory interface as another feature of the Squarespace Compute Platform

---
# v0 Goals
- Provide read-only access to what is currently represented by the Ansible inventory files
- Provide an interface which is decoupled from the Ansible inventory schema
- Abstract users of the inventory from needing to read the inventory files from the Ansible repo
- Keep it simple

---
# v0 Non-Goals
- Allow write access to the inventory via this API
- Expose any group_var information via this API
- Design a full dynamic inventory system

---
# Initial Motivation
Programmatic access to hosts in the inventory is needed for the VM Provisioning Operators

---
# Initial Motivation
There are a number of other systems which read off the Ansible inventory as a source of truth

---
# Possible Clients
- VM Provisioner Operator
- Pyline
- Automated database provisioning
- Kubesync (inventory host sync to ConfigMap)
- Addressbook firewall validation
- DNS Record Updating

---
# v0 API Design
gRPC HTTP Gateway

> - /api/v1/inventory/{environment}
- /api/v1/inventory/hosts/{name}
- /api/v1/inventory/groups/{name}
- /api/v1/inventory/{environment}/groups/{group}
- /api/v1/inventory/ips/{ip}

---
# v0 API Implementation
The interface will not lead details of the Ansible implementation

---
# v0 API Implementation
When querying for an IP you will get a Hostname, not variables

---
# v0 Deployment
How do you keep the inventory files fresh?

---
# v0 Deployment
Built off the Ansible container on every `develop` build

---
# Timeline
A proof of concept is running to support the development of the VM Provisioning Operator

---
# Timeline
Clients are welcome to use it at this time

---
# Timeline
Chat with Compute before integrating to that we make sure your use case is covered.

---
# Dependencies
- Ansible static inventory files
- Ansible container

---
# Future work
- Dynamic inventory
- Edit access to inventory

---
# Future work
If you have ideas, come chat! come whiteboard!

---
# Thank you



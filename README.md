# Terraform configuration

This is the repository for my server on the UL campus. This repository is being used with Terraform Cloud to automatically deploy new configurations to the server through their CD pipeline.

## Branches

I am using the main branch as an intermediary for the _production_ branch that is being deployed automatically. I am not merging all the changes that don't affect the code (like changing this file) to from _main_ to _production_.
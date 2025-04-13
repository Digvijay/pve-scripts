# Proxmox VM Template and Clone Creation

This repository contains scripts and configuration files to create a QEMU-based VM template and use it to create a full clone on a Proxmox hypervisor. Follow the steps below to set up and execute the process.

---

## Prerequisites

1. Ensure you have a Proxmox hypervisor set up and accessible.
2. Install necessary tools like `curl`, `gpg`, and `wget` on the machine where you will run the scripts.

---

## Installation of Mise

To install Mise, navigate to the `.mise` directory and execute the `setup.sh` script:

```bash
cd .mise
bash setup.sh
```

This script will:
- Import the Mise GPG key.
- Download and verify the Mise installation script.
- Install Mise and configure it for your shell.

Follow the instructions printed by the script to activate Mise for your shell.

---

## Setting Up the `.env` File

The `.env` file contains environment variables required by the `create-template-jammy-minimal.sh` script. To set it up:

1. Copy the `.env.template` file to `.env`:

   ```bash
   cp .env.template .env
   ```

2. Edit the `.env` file to customize the variables as needed:

   ```bash
   nano .env
   ```

   Example variables:
   - `VMUSER`: The username for the VM.
   - `VMPASSWORD`: The password for the VM.
   - `TEMPLATE_ID`: The ID for the VM template.
   - `CLONE_ID`: The ID for the cloned VM.
   - `CLONE_NAME`: The name for the cloned VM.

---

## Executing the Script

To create a QEMU-based VM template and a full clone:

1. Ensure the `.env` file is properly configured.
2. Run the `create-template-jammy-minimal.sh` script:

   ```bash
   bash create-template-jammy-minimal.sh
   ```

This script will:
- Download the Ubuntu Jammy cloud image.
- Create a VM template with the specified configuration.
- Clone the template to create a new VM with the specified ID and name.

---

## Notes

- The `authorized_keys` file is used to set up SSH access for the VM. Ensure it contains the correct public key.
- The `.gitignore` file excludes sensitive files like `.env` and `authorized_keys` from version control.

For any issues or questions, refer to the script comments or contact the repository maintainer.
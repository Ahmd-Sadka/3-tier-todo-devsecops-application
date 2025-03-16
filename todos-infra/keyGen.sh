#!/bin/bash
set -euo pipefail

KEY_NAME="pipelineKey"
KEY_DIR="${HOME}/.ssh/zen-keys"
TERRAFORM_KEY_DIR="./keys"


mkdir -p "$KEY_DIR" "$TERRAFORM_KEY_DIR"
chmod 700 "$KEY_DIR"


if [[ ! -f "${KEY_DIR}/${KEY_NAME}" ]]; then
    ssh-keygen -t ed25519 -a 100 -C "pipeline-$(date +%Y-%m-%d)" -f "${KEY_DIR}/${KEY_NAME}" -N ""
    chmod 400 "${KEY_DIR}/${KEY_NAME}"
    
  
    cp "${KEY_DIR}/${KEY_NAME}.pub" "${TERRAFORM_KEY_DIR}/"
    echo "public_key_path = \"${TERRAFORM_KEY_DIR}/${KEY_NAME}.pub\"" >> ./terraform.tfvars
fi


if ! grep -q "${KEY_DIR}" .gitignore; then
    echo -e "\n# Project SSH keys\n${KEY_DIR}" >> ../.gitignore
fi

echo "✅ Generated ED25519 keys with rotation-ready structure"
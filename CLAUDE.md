# Global Infrastructure Development Conventions

## Identity & Context

- Engineer: Dennis Rausch, ML Platform / Infrastructure at Proofpoint
- Primary cloud: AWS (60+ SSO profiles, EKS clusters), Azure and GCP secondary
- IaC stack: Terraform + Terragrunt (AWS), Helm (Kubernetes; Kustomize
  acceptable as chart input via the kubebuilder helm plugin)
- Languages: Go (services, operators), Python (ML, scripts), Lua (Neovim)

## Terraform Conventions

- Always use Terragrunt wrapper; raw terraform commands only in leaf modules
- Module source: private registry or git::ssh URLs, never public registry
  without pinned version
- Backend: S3 + DynamoDB, configured via Terragrunt generate blocks
- Naming: snake_case for resources, kebab-case for tags
- Every resource MUST have tags: Environment, Team, Service, ManagedBy=terraform
- Use data sources to reference cross-stack resources, never hardcode ARNs
- Variable descriptions are mandatory; include `type`, `description`, and
  `default` where sensible
- Pin provider versions with ~> constraints in required_providers
- Run `terraform fmt` and `terraform validate` before suggesting any Terraform
  change
- Run `tfsec` on any security-sensitive resources (IAM, security groups, KMS)

## Kubernetes Conventions

- EKS clusters accessed via aws-sso + kubeconfig
- Helm charts, rarely raw YAML
- Helm is the default packaging/distribution format for both third-party and
  in-house services. For kubebuilder operators, use the `helm/v2-alpha` plugin
  to generate `dist/chart/` from the Kustomize sources under `config/`.
- Namespace naming: {team}-{service}-{env}
- Always include resource requests/limits, PDBs, and anti-affinity for
  production
- Validate manifests with kubeconform and conftest before applying
- Never apply directly to production clusters from local machine

## AWS Conventions

- Authentication: `aws-sso` CLI
- Always verify active profile with `aws sts get-caller-identity` before any AWS
  operation
- Cross-account access via assume-role, configured in Terragrunt
- Region: us-east-1 primary, us-west-2 DR unless otherwise specified

## Security Requirements

- Never output or log AWS credentials, tokens, or secrets
- Never commit .env files, credentials, or kubeconfig with embedded tokens
- All IAM policies must follow least-privilege; no Action: "_" or Resource: "_"
- Security groups: no 0.0.0.0/0 ingress except on ALBs with WAF
- Encryption at rest required for all data stores (S3, EBS, RDS, DynamoDB)
- Run `conftest test` against OPA policies for any Kubernetes manifest changes

## Code Generation Preferences

- Prefer composable Terraform modules over monolithic configurations
- For Go: follow standard project layout, use interfaces for testability
- For Python: use uv for dependency management, type hints mandatory
- Tests: every Terraform module gets a `tests/` directory with at least plan
  validation

## Git Workflow

- Branch naming: {type}/{ticket}-{short-description} (e.g.,
  feat/FORGE-1234-add-eks-addon)
- Commit messages: conventional commits (feat:, fix:, chore:, docs:); must
  always contain ticket id.
- Always run pre-commit hooks before committing
- Infrastructure changes require plan output in PR description

## <!--# BEGIN SNYK GLOBAL RULE -->

alwaysApply: true always_on: true trigger: always_on applyTo: "\*\*"
description: Snyk Security At Inception

---

# Project security best practices

- Always run snyk_code_scan tool for new first party code that is generated in a
  Snyk-supported language.
- If any security issues are found based on newly introduced or modified code or
  dependencies, attempt to fix the issues using the results context from Snyk.
- Rescan the code after fixing the issues to ensure that the issues were fixed
  and that there are no newly introduced issues.
- Repeat this process until no new issues are found.
<!--# END SNYK GLOBAL RULE -->

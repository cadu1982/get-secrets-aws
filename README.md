# Get Secrets Name and Values From AWS Secrets Manager

This action is responsible for getting secret names and values to send them to the **GITHUB_ENV** file as environment variables. Therefore, to use this action, you need to specify the following information and steps:

<br>

```yaml
(...)

  env:
    SERVER: "dev" # Environment suffix (eg: "dev", "pprd", "sdx", and "prod")

  steps:

      (...)

      - name: Split the owner and name of a repository
        uses: Add-Jazztech/github-split-repo-owner-name-action@v1.0.0

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_<ENVIRONMENT_SUFFIX>_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_<ENVIRONMENT_SUFFIX>_SECRET_KEY }}
          aws-region: us-east-1
          mask-aws-account-id: true

      - name: Get Secrets From AWS Secrets Manager
        uses: Add-Jazztech/github-get-secrets-aws-action@v1.0.0
        with:
          app-reference: ${{ env.GITHUB_REPO_NAME }}
          environment-reference: ${{ env.SERVER }}

(...)
```

<br>

In the **"Configure AWS Credentials"** step, the values of the inputs **aws-access-key-id** and **aws-secret-access-key** need to be the values below, representing each environment:

<br>

**Development (DEV):**

<br>

- **aws-access-key-id:** ${{ secrets.AWS_DEV_ACCESS_KEY_ID }};
- **aws-secret-access-key:** ${{ secrets.AWS_DEV_ACCESS_SECRET_KEY }}.

<br>

**Pre-Production (PPRD):**

<br>

- **aws-access-key-id:** ${{ secrets.AWS_PPRD_ACCESS_KEY_ID }};
- **aws-secret-access-key:** ${{ secrets.AWS_PPRD_ACCESS_SECRET_KEY }}.

<br>

**Sandbox (SDX):**

<br>

- **aws-access-key-id:** ${{ secrets.AWS_SDX_ACCESS_KEY_ID }};
- **aws-secret-access-key:** ${{ secrets.AWS_SDX_ACCESS_SECRET_KEY }}.

<br>

**Production (PROD):**

<br>

- **aws-access-key-id:** ${{ secrets.AWS_PROD_ACCESS_KEY_ID }};
- **aws-secret-access-key:** ${{ secrets.AWS_PROD_ACCESS_SECRET_KEY }}.

<br>

It's important to mention that after this step the secrets will be available to the application inside the container that the application is performing.

# Kanidm Management Documentation

This document provides a step-by-step guide to managing users, groups, and configurations in Kanidm using the command-line interface (CLI). The commands are executed in a Kubernetes environment where Kanidm is deployed.

## Configuration

Before executing any commands, ensure that the Kanidm CLI is configured with the correct URI.

```bash
echo 'uri = "https://auth.myr-project.eu:31501"' > ~/.config/kanidm
```

This command sets the URI for the Kanidm server in the configuration file.

## Admin Password Recovery

To recover the admin password, use the following command:

```bash
kubectl exec -it <kanidmd-pod> -n kanidm -- kanidmd recover-account idm_admin
```

z7ZTXBXqTZd9RTZeu67exAqV5vy3DzkuRVk3wPTsEvp1yfvC

Replace `<kanidmd-pod>` with the actual pod name where Kanidm is running.

## Login

After recovering the admin password, log in to Kanidm using the following command:

```bash
kanidm login -D idm_admin
```

You will be prompted to enter the admin password.

## Domain Configuration

Set the display name for the domain:

```bash
kanidm system domain set-displayname "MyR Project" --name idm_admin
```

## User Management

### Create a Demo User

Create a new user with the following command:

```bash
kanidm person create utilisateur_demo "Jean Eude" --name idm_admin
```

### Retrieve User Information

To retrieve information about the created user:

```bash
kanidm person get utilisateur_demo --name idm_admin
```

### Update User Information

Update the user's legal name and email:

```bash
kanidm person update utilisateur_demo --legalname "Jean Eude" --mail "jean.eude@myr-project.eu" --name idm_admin
```

## Password Reset

### Create a Password Reset Token

To create a password reset token for the user:

```bash
kanidm person credential create-reset-token utilisateur_demo 86400 --name idm_admin
```

The token will be valid for 86400 seconds (24 hours).

### Update User Password

To update the user's password as an admin:

```bash
kanidm person credential update utilisateur_demo --name idm_admin
```

Unix password :
chibreRouxNoir

## Group Management

### Create a Demo Group

Create a new group:

```bash
kanidm group create groupe_demo --name idm_admin
```

### Add User to Group

Add the demo user to the group:

```bash
kanidm group add-members groupe_demo utilisateur_demo --name idm_admin
```

### List Group Members

List all members of the group:

```bash
kanidm group list-members groupe_demo --name idm_admin
```

### Create a VPN Access Group

Create a group for VPN access:

```bash
kanidm group create acces_vpn --name idm_admin
```

### Add User to VPN Access Group

Add the demo user to the VPN access group:

```bash
kanidm group add-members acces_vpn utilisateur_demo --name idm_admin
```

### List VPN Access Group Members

List all members of the VPN access group:

```bash
kanidm group list-members acces_vpn --name idm_admin
```

## POSIX Attributes

### Set POSIX Attributes for User

Set POSIX attributes for the demo user:

```bash
kanidm person posix set --name idm_admin utilisateur_demo
```

### Set User's Shell

Set the user's shell to `/bin/zsh`:

```bash
kanidm person posix set --name idm_admin utilisateur_demo --shell /bin/zsh
```

### Set User's GID

Set the user's GID to `2001`:

```bash
kanidm person posix set --name idm_admin utilisateur_demo --gidnumber 2001
```

## Conclusion

This documentation provides a comprehensive guide to managing users, groups, and configurations in Kanidm using the CLI. Ensure that you have the necessary permissions and replace placeholders with actual values as needed.

# Troubleshooting

Use this as the standard troubleshooting method across Windows, Linux, networking, cloud, and AI phases.

## Method

1. Define the expected behavior.
2. Capture the actual behavior.
3. Identify the affected system and scope.
4. Check the simplest dependency first.
5. Change one thing at a time.
6. Validate the fix.
7. Document the root cause.
8. Add prevention or monitoring if appropriate.

## Active Directory Join Failures

Check in order:

1. Client IP address.
2. Gateway.
3. DNS points to `DC01`.
4. `ping DC01`.
5. `nslookup DC01`.
6. Time synchronization.
7. Domain credentials.
8. Existing stale computer account.
9. Domain controller health.

## PowerShell Remoting Failures

Check:

- WinRM service status.
- Firewall rules.
- DNS resolution.
- TrustedHosts only when appropriate.
- Domain authentication.
- Local administrator or delegated permissions.
- Whether the command is running locally or remotely.

## File Share Access Issues

Check:

- Share permissions.
- NTFS permissions.
- Group membership.
- User token refresh or logoff/logon.
- Network path.
- DNS.
- Most restrictive permission wins.

## Linux SSH Issues

Check:

- IP address and route.
- SSH service status.
- Firewall.
- Username.
- Key permissions.
- Password authentication policy.
- Host key changes.

## Evidence To Capture

- Command used.
- Host where the command ran.
- Error message.
- Root cause.
- Fix.
- Validation result.
- Lesson learned.

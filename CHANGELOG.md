# 0.1.2 (Jun 10, 2026)
* Cron-triggered task runs now set two environment variables your app can read:
  * `NULLSTONE_TRIGGER` — `cron` when the run was started by this schedule, so your code can tell a scheduled run from a manual one.
  * `NULLSTONE_TRIGGER_NAME` — the name of this cron capability, so you can tell multiple schedules on the same app apart.

# 0.1.1 (May 26, 2026)
* Improved IAM policy for events role.

# 0.1.0 (Jun 21, 2023)
* Initial release

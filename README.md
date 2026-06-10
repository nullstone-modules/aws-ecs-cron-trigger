# Scheduled Trigger for ECS/Fargate

Nullstone capability to trigger an ECS/Fargate app or job on a cron schedule.

## Telling cron runs apart from manual runs

Every scheduled run starts the ECS task with two environment variables your app can read:

| Variable                 | Value                                                                          |
|--------------------------|--------------------------------------------------------------------------------|
| `NULLSTONE_TRIGGER`      | `cron` — the run was started by this schedule (not a manual `nullstone run`)    |
| `NULLSTONE_TRIGGER_NAME` | the name of this cron capability — identifies *which* schedule fired the run    |

These are applied as **container overrides** on the scheduled `RunTask`. A manual `nullstone run` instead sets
`NULLSTONE_TRIGGER=manual`, so your app can positively tell the two apart by the value of `NULLSTONE_TRIGGER`, and
`NULLSTONE_TRIGGER_NAME` lets you distinguish multiple schedules attached to the same app.

Example (Node.js):

```js
if (process.env.NULLSTONE_TRIGGER === "cron") {
  console.log(`Started by cron schedule: ${process.env.NULLSTONE_TRIGGER_NAME}`);
} else {
  console.log("Started manually");
}
```

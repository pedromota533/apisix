# Helm Values

## What is `values.yaml`

Every Helm chart has an internal `values.yaml` with hundreds of default settings. When you install a chart, you can pass your own `values.yaml` with `-f` to **override** only the values you want to change. Everything else keeps its default.

## Our `values.yaml`

```yaml
admin:
  enabled: true        # enables the Admin API (disabled by default)
  credentials:
    admin: admin       # admin user password
    viewer: viewer     # viewer user password
```

## How Helm reads it

```bash
helm install apisix apisix/apisix -f values.yaml
```

Helm does a **deep merge**:

```
Chart defaults (hundreds of values)
        ↓
  Your values.yaml (overrides)
        ↓
  Final configuration applied to Kubernetes
```

Only the keys you specify are overridden. Everything else stays as the chart author defined.

## See all available options

```bash
./bin/helm show values apisix/apisix
```

This prints the full default `values.yaml` from the chart with all options you can override.

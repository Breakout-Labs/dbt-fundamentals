## 📋 Description & Motivation

<!--  What changed and why? -->

&nbsp;

---

## 🌐 DAG screenshot

<!-- dbt Cloud → Explore, or run `dbt docs generate && dbt docs serve` -->

&nbsp;

---

## ✅ UAT: does the data look right?

<!-- Paste a query result or screenshot that proves the output is correct -->

&nbsp;

---

## 📝 Checklist

**Before requesting review**
- [ ] `dbt build --select +<model>+` ran successfully
- [ ] I have reviewed my own code and models

**Code**
- [ ] Uses `{{ ref() }}` and `{{ source() }}` (no hardcoded schema names)
- [ ] Correct layer: `staging/` > `intermediate/` > `marts/`
- [ ] Naming convention: `stg_<source>__<object>`
- [ ] Repeated logic extracted into a macro

**Docs & tests**
- [ ] Model and column descriptions added to `.yml`
- [ ] `unique` + `not_null` tests on primary keys

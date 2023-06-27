# pnpm Version Bug Tester

This is a tester to run tests of a version resolution bug of pnpm in multiple pnpm versions then generate result.

For detail, see https://github.com/pnpm/pnpm/issues/6716

## How to use

This repo contains two package.json, the `package.template.json` is a template,it will copy and overwrite to `package.json` to create a fresh package.json to test.

To test, you can use `sh test.sh` to quickly test few latest versions or use npm to run `npm run version-test --pnpm_version=<version>` to test in a specific version of pnpm.

### **WARNING**

The script will install specific pnpm version globally, and use it to run the test, so it will overwrite your global pnpm version.

## What it will do?

The script will do the following things:

1. Install specific pnpm version globally
2. Delete `version` folder if exist, which is used to temporary store the test result.
3. Create a folder named `version` and will be used to store results later.
4. Remove `node_modules`, `pnpm-lock.yaml` if exists, and copy `package.template.json` to `package.json` to create a fresh environment.
5. Sequentially run `pnpm add` for each following version: `vue@2.0`, `vue@^2.0` and `vue@~2.0`, export stdout results and `package.json` to `version` folder, reset environment after each test.
6. Sequentially run `pnpm install` for each above installed version by restore `package.json`, export stdout results to `version` folder.
7. Done. Prints result in markdown.

---

## Test result

Following table is a test result running on my machine using `CentOS 3.10.0-1160.90.1.el7.x86_64`.

Since the official install script cannot install lower version, I did not test them.

|        | v2.3 (add) | v2.3 (install) | v2.3.0 (add) | v2.3.0 (install) | major-v2.3 (add) | major-v2.3 (install) | minor-v2.3.0 (add) | minor-v2.3.0 (install) |
| :----: | :--------: | :------------: | :----------: | :--------------: | :--------------: | :------------------: | :----------------: | :--------------------: |
| 8.6.5  |  ✔️ 2.3.4  |    ❔ 2.3.0    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |       ❌ 2.3.0       |      ✔️ 2.3.4      |        ❌ 2.3.0        |
| 8.5.1  |  ✔️ 2.3.4  |    ❔ 2.3.0    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |       ❌ 2.3.0       |      ✔️ 2.3.4      |        ❌ 2.3.0        |
| 8.4.0  |  ✔️ 2.3.4  |    ❔ 2.3.0    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |       ❌ 2.3.0       |      ✔️ 2.3.4      |        ❌ 2.3.0        |
| 8.3.1  |  ✔️ 2.3.4  |    ❔ 2.3.0    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |       ❌ 2.3.0       |      ✔️ 2.3.4      |        ❌ 2.3.0        |
| 8.2.0  |  ✔️ 2.3.4  |    ❔ 2.3.0    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |       ❌ 2.3.0       |      ✔️ 2.3.4      |        ❌ 2.3.0        |
| 8.1.1  |  ✔️ 2.3.4  |    ❔ 2.3.0    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |       ❌ 2.3.0       |      ✔️ 2.3.4      |        ❌ 2.3.0        |
| 8.0.0  |  ✔️ 2.3.4  |    ❔ 2.3.0    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |       ❌ 2.3.0       |      ✔️ 2.3.4      |        ❌ 2.3.0        |
| 7.33.2 |  ✔️ 2.3.4  |    ✔️ 2.3.4    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |      ✔️ 2.7.14       |      ✔️ 2.3.4      |        ✔️ 2.3.4        |
| 7.32.5 |  ✔️ 2.3.4  |    ✔️ 2.3.4    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |      ✔️ 2.7.14       |      ✔️ 2.3.4      |        ✔️ 2.3.4        |
| 7.1.0  |  ✔️ 2.3.4  |    ✔️ 2.3.4    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |      ✔️ 2.7.14       |      ✔️ 2.3.4      |        ✔️ 2.3.4        |
| 6.35.1 |  ✔️ 2.3.4  |    ✔️ 2.3.4    |   ✔️ 2.3.0   |     ✔️ 2.3.0     |    ✔️ 2.7.14     |      ✔️ 2.7.14       |      ✔️ 2.3.4      |        ✔️ 2.3.4        |

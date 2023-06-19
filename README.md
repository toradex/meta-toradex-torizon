# Common TorizonCore

![Common Torizon cover image](https://github.com/commontorizon/Documentation/blob/main/assets/img/commonTorizonCore800.png?raw=true)

Common TorizonCore is an embedded Linux distribution for the Torizon platform. It
features, among other essential services, a container runtime and components
for secure remote over-the-air (OTA) updates.

This layer provides the necessary metadata to build the Common TorizonCore Linux
distribution.

> ⚠️ **DISCLAIMER:** this is a derivative work from TorizonCore open source project. Torizon™ is a registered trademark of Toradex Group AG. This derivative work have not been reviewed or approved by Toradex. Common Torizon community does not talk on behalf of Toradex.
>
>⚠️ **This software is provided experimentally as-is.**

## Building

General documentation for the community can be found here: <https://github.com/commontorizon/Documentation>

## Feature Support

Our goal is to have Common TorizonCore in feature parity with TorizonCore. The table below shows the current status of each key feature:

| Feature                      | Toradex SoM | Rpi3 | Rpi4 | Nezha D1 | x86-64 | Beagle Bone Black |
| ---------------------------- | ----------- | ---- | ---- | -------- | ------ | ----------------- |
| OTA Update OS Image          | ✅           |      | ✅     |          |        |                  |
| OTA Update Container App     | ✅           | ✅    | ✅    | ✅        | ✅      | ✅                 |
| OTA Update Bootloader        | ✅           |      |      |          |        |                   |
| Device Monitoring            | ✅           | ✅    | ✅    | ✅        | ✅      | ✅                 |
| LTS Hardware & BSP           | ✅           |      |      |          |        |                   |
| Free Technical Support       | ✅           |      |      |          |        |                   |
| Prebuilt TorizonCore Image   | ✅           | ✅    | ✅    | ✅        | ✅      | ✅                 |
| QA Approved Releases         | ✅           |      |      |          |        |                   |
| Provisioning with TEZI*      | ✅           |      |      |          |        |                   |
| Image Customizing with TCB** | ✅           |      |      |          |        |                   |
| VS Code extension 2 support  | ✅           | ✅    | ✅    | ⚠️***    | ⚠️***  | ✅                 |

> ⚠️* **TEZI**: Toradex Easy Installer
⚠️** **TCB**: TorizonCore Builder
⚠️*** **VS Code Extension**: are not all the templates that support RISC-V and x86-64 architectures

## License

All metadata is [MIT licensed](./LICENSE) unless otherwise stated. Source code and
binaries included in tree for individual recipes is under the LICENSE
stated in each recipe unless otherwise stated.

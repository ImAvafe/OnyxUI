---
sidebar_position: 5
---

# Styling Props

`UIPadding`s, `UIStroke`s, `UIListLayout`s, `UIAspectRatio`s... Children-based styling is just too much boilerplate. In OnyxUI, all components support an extensive set of props to avoid working with these objects.

For a full list of supported styling props, see the [`Base`](/api/Base) component.

## Use in custom components

To support styling props in your own components, make use of the [`CombineProps`](/api/Util#CombineProps) utility to pass props through automatically.
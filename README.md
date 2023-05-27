<img src="https://raw.githubusercontent.com/jsdotlua/branding/main/Logo.png" align="right" height="128"/>

# VirtualizedList Lua
### High-performance virtualized scrolling lists for [react-lua](https://github.com/jsdotlua/react-lua).

<a href="https://github.com/jsdotlua/virtualized-list-lua/blob/main/LICENSE.md">
<img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="license" height="18">
</a>

<a href="https://github.com/jsdotlua/virtualized-list-lua/actions/workflows/ci.yml">
<img src="https://github.com/jsdotlua/virtualized-list-lua/actions/workflows/ci.yml/badge.svg" alt="CI" height="18">
</a>

---

A collection of virtual list components, supporting the most handy features:

- Fully cross-platform
- Optional horizontal mode
- Configurable viewability callbacks
- Header support
- Footer support
- Separator support
- Pull to Refresh
- Scroll loading
- ScrollToIndex support
- Multiple column support

Virtualization massively improves memory consumption and performance of large lists by maintaining a finite render window of active items and replacing all items outside of the render window with appropriately sized blank space. The window adapts to scrolling behavior, and items are rendered incrementally with low-pri (after any running interactions) if they are far from the visible area, or with hi-pri otherwise to minimize the potential of seeing blank space.

## Caveats

Virtualized lists aren't appropriate for all situations. Here's some caveats:

- Internal state is not preserved when content scrolls out of the render window. Make sure all your data is captured in the item data or an external store like Rodux.
- Everything is a `PureComponent`, which means that it will not re-render if `props` are shallow-equal. Make sure that everything your `renderItem` function depends on is passed as a prop (e.g. `extraData`) that is not shallow-equal after updates, otherwise your UI may not update on changes. This includes the `data` prop and parent component state.
- In order to constrain memory and enable smooth scrolling, content is rendered asynchronously offscreen. This means it's possible to scroll faster than the fill rate and momentarily see blank content. This is a tradeoff that can be adjusted to suit the needs of each application.
- By default, the lists look for a `key` prop on each item and uses that for the React key. Alternatively, you can provide a custom `keyExtractor` prop.

## Example

```lua
local React = require(...)
local VirtualizedList = require(...)

local View = VirtualizedList.View
local FlatList = VirtualizedList.FlatView

local e = React.createElement

local DATA = {
  {
    id: 'bd7acbea-c1b1-46c2-aed5-3ad53abb28ba',
    title: 'First Item',
  },
  {
    id: '3ac68afc-c605-48d3-a4f8-fbd91aa97f63',
    title: 'Second Item',
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d72',
    title: 'Third Item',
  },
}

local function Item(props)
    return e(View, {}, {
        e("TextLabel", {
            Size = UDim2.new(1, 0, 0, 40),
            Text = props.title,
        })
    })
end

local function App()
    return e(FlatList, {
        data = DATA,
        renderItem = Item,
    })
end
```

## Documentation

More information on the provided list components can be found at:

- `VirtualizedList` - https://reactnative.dev/docs/virtualizedlist
- `FlatList` - https://reactnative.dev/docs/flatlist
- `SectionList` - https://reactnative.dev/docs/sectionlist

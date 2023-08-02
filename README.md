<img src="https://raw.githubusercontent.com/jsdotlua/branding/main/Logo.png" align="right" height="128"/>

# VirtualizedList Lua
### High-performance scrolling lists ported from React Native for [react-lua](https://github.com/jsdotlua/react-lua).

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
- Animation suppot

Virtualization massively improves memory consumption and performance of large lists by maintaining a finite render window of active items and replacing all items outside of the render window with appropriately sized blank space. The window adapts to scrolling behavior, and items are rendered incrementally with low-priority (after any running interaction responses) if they are far from the visible area, or with high-priority otherwise to minimize the potential of seeing blank space.

## Caveats

Virtualized lists aren't appropriate for all situations. Here's some caveats:

- Internal state is not preserved when content scrolls out of the render window. Make sure all your data is captured in the item data or an external store like Rodux.
- Everything is a `PureComponent`, which means that it will not re-render if `props` are shallow-equal. Make sure that everything your `renderItem` function depends on is passed as a prop (e.g. `extraData`) that is not shallow-equal after updates, otherwise your UI may not update on changes. This includes the `data` prop and parent component state.
- In order to constrain memory and enable smooth scrolling, content is rendered asynchronously offscreen. This means it's possible to scroll faster than the fill rate and momentarily see blank content. This is a tradeoff that can be adjusted to suit the needs of each application.
- By default, the lists look for a `key` prop on each item and uses that for the React key. Alternatively, you can provide a custom `keyExtractor` prop.

## Example

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage.Packages

local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local VirtualizedList = require(Packages.VirtualizedList)

local View = VirtualizedList.View
local FlatList = VirtualizedList.FlatList

local e = React.createElement

local ITEM_COUNT = 10_000
local DATA = table.create(ITEM_COUNT)

for i = 1, ITEM_COUNT do
  DATA[i] = {
    id = HttpService:GenerateGUID(false),
    title = `Item {i}`,
  }
end

local function Item(props)
  return e(View, {}, {
    ItemText = e("TextLabel", {
      Size = UDim2.new(1, 0, 0, 40),
      Text = props.title,
    }),
  })
end

local function App()
  return e("ScreenGui", {
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
  }, {
      Background = e("Frame", {
      AnchorPoint = Vector2.new(0.5, 0.5),
      Position = UDim2.fromScale(0.5, 0.5),
      Size = UDim2.fromScale(0.25, 0.4),
    }, {
      List = e(FlatList, {
        data = DATA,
        renderItem = function(entry)
          return e(Item, {
            title = entry.item.title,
          })
        end,
        keyExtractor = function(entry)
          return entry.id
        end,
      }),
    }),
  })
end

local root = ReactRoblox.createRoot(Instance.new("Folder"))
root:render(ReactRoblox.createPortal(e(App), Players.LocalPlayer.PlayerGui))
```

## Documentation

These components are directly ported from React Native 0.68, so most documentation and articles should apply (modulo Lua syntax). More information on the provided list components can be found at:

- `VirtualizedList` - https://reactnative.dev/docs/virtualizedlist
- `FlatList` - https://reactnative.dev/docs/flatlist
- `SectionList` - https://reactnative.dev/docs/sectionlist

## TODO

- Add unit tests from upstream React Native
- Use `darklua` bundler to allow more files to easily run outside of Roblox
- Add performance benchmarks

<img src="https://raw.githubusercontent.com/jsdotlua/branding/main/Logo.png" align="right" height="128"/>

# VirtualizedList Lua
### A collection of high-performance virtualized scrolling lists for [react-lua](https://github.com/jsdotlua/react-lua).

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

## Documentation

More information on the provided list components can be found at:

- `VirtualizedList` - https://reactnative.dev/docs/virtualizedlist
- `FlatList` - https://reactnative.dev/docs/flatlist
- `SectionList` - https://reactnative.dev/docs/sectionlist

/// How zmanim ("times of day") descriptions are displayed in the list.
enum ZmanimDisplayMode {
  /// All rows collapsed; tapping a row toggles it; multiple can stay open.
  multiExpand,

  /// All rows collapsed; tapping a row expands it and collapses any other
  /// (only one open at a time).
  singleExpand,

  /// All rows expanded on load; tapping a row collapses it.
  expandedByDefault,
}

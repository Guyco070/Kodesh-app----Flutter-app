# Kodesh widget and helper catalog

Shared building blocks. Check here before writing something new; update this file in the
same commit when you add, rename or remove one. Paths are under `lib/`.

## Page structure

| Widget | Path | Use for |
|---|---|---|
| `DefaultScaffold` | `widgets/default_scaffold.dart` | The main screen only: app bar with drawer button and language picker, plus the drawer. |
| `CustomAppBar` | `widgets/custom_app_bar.dart` | App bar of every other screen: back button, centered title (announced as a heading), optional `leading`/`trailing`/`titleWidget`. |
| `AppDrawer` | `widgets/app_drawer.dart` | The navigation drawer. Add new screens here. |
| `LoadingScaffold` | `widgets/loading_scaffold.dart` | Main-screen scaffold showing only a spinner while the app starts. |
| `InfoPageBody` + `InfoPageSection` | `widgets/info_page/info_page_body.dart`, `models/info_page_section.dart` | Any long text page (About, Accessibility, Privacy): readable width, selectable, keyboard-scrollable. Content goes in `data/site_pages_content.dart`. |
| `TefilaWidget` | `widgets/tefila_widget.dart` | Prayer/blessing screens: optional image, nusach switch, text size buttons, formatted text from `Tfilot.getSederWidgets`. |

## Containers and layout

| Widget | Path | Use for |
|---|---|---|
| `GroupCard` | `widgets/group_card.dart` | A card grouping related settings or rows (`children`, `elevation`). |
| `CustomExpandedListView` | `widgets/custom_expanded_list_view.dart` | Collapsible titled section (drawer sections). Controlled: `isExpanded` + `onToggle`. |
| `ExpandedSection` | `animations/expanded_section.dart` | Animated show/hide of any child (`expand`). |

## Inputs and controls

| Widget | Path | Use for |
|---|---|---|
| `SearchFilterBar` | `widgets/search_filter_bar.dart` | Text filter above a list, with a labelled clear button. |
| `CitySearchDelegate` | `widgets/city_picker.dart` | Picking a city (`showSearch`). |
| `SettingsFilterChip` | `widgets/settings_bar/settings_filter_chip.dart` | On/off display filter with a visible checked state. Belongs to `SettingsBar`; promote it before reusing elsewhere. |
| `CuperinoTextCheckSwitch` | `widgets/swiches/cupertino_text_check_switch.dart` | Labelled switch row in settings. |
| `ViewTypeSwitch` / `ViewTypeTab` | `widgets/swiches/view_type_switch.dart` | Two-way "events / today's times" switch on the main screen; `ViewTypeTab` exposes the selected state correctly. |
| `ChooseTimeBeforeWidget` | `widgets/schedule_notifications_widgets/choose_time_before_widget.dart` | Pick "N hours/minutes before" for a reminder. |
| `ChooseTimeInDayWidget` | `widgets/schedule_notifications_widgets/choose_time_in_day_widget.dart` | Pick a time of day for a daily reminder. |
| `CompassButton` | `widgets/compass/compass_button.dart` | Small compass shortcut in an app bar (labelled). |

## Showing data

| Widget | Path | Use for |
|---|---|---|
| `EventFactoryWidget` | `widgets/events_widgets/event_factory_widget.dart` | Renders any `Event` with its heading; picks the right widget via `Events.eventsFactoryMethod`. Add new event types there. |
| `ShabatWidget`, `HolidayWidget`, `RoshChodeshWidget`, `SfiratOmerWidget`, `MoladWidget` | `widgets/events_widgets/` | Body of each event type. `MoladWidget` is a compact note without a heading. |
| `FastTimesSection` | `widgets/events_widgets/holiday_widget/fast_times_section.dart` | Fast begin/end times inside `HolidayWidget`. |
| `ZmanWidget` | `widgets/zman_widget.dart` | One halachic time row with expandable explanation. |
| `DateWithTimeLeft` | `widgets/date_with_time_left.dart` | Date (optionally Hebrew) + weekday + "in N days". Default choice for an event date. |
| `TimeLeft` | `widgets/time_left.dart` | Only the countdown text. |
| `ThingToRemind` | `widgets/thing_to_remind.dart` | Square icon + label tile (pre-Shabbat checklist grid). Sizes itself from its constraints. |
| `MonthlyCalendarView` | `widgets/holiday_calendar/monthly_calendar_view.dart` | Month grid of holidays; fetches month by month. Its cells/header/sheet live in `monthly_calendar_view/`. |
| `CompassWidget` | `widgets/compass/compass_widget.dart` | The full compass with permission/unsupported states. |

## Animations

| Widget | Path | Use for |
|---|---|---|
| `AnimatedZmanimList` | `animations/animated_zmanim_list.dart` | Keyed list whose new items slide in and filtered items don't re-animate. **Preferred** for new animated lists. |
| `AnimatedEventsListView`, `AnimatedOnlyShabatListView` | `animations/` | Older slide-in lists for events. Don't copy; converge on `AnimatedZmanimList`. |
| `SlideInAnimation` | `animations/slide_in_animation.dart` | Slide one widget in on first build. |
| `AnimatedLongText` | `animations/animated_long_text.dart` | Text that collapses to one line with ellipsis and expands (controlled by `expanded`). |
| `HeroDialogRoute`, `CustomRectTween` | `animations/hero_dialog_route.dart`, `widgets/compass/custom_rect_tween.dart` | Hero transition into a dialog (compass). |

## Helpers (not widgets)

| Helper | Path | Use for |
|---|---|---|
| `logger` | `helpers/app_logger.dart` | All logging. Never `print`. |
| `getDayName`, `getTime`, `getDushedFormatedDate`, `isToday`, `isYesterdayTodayOrTomorrow`, `getDateTimeSetToZero`, `getSingleElementZeroAdded` | `helpers/dates.dart` | Date utilities (calendar-day comparisons are DST-safe). For text shown to users prefer `DateFormat` with the locale. |
| `cityDisplayName` | `helpers/city_display.dart` | City label without the "CC-" prefix. |
| `LocationService.detectNearestCity` | `services/location_service.dart` | Nearest supported city from GPS. |
| compass service | `services/compass_service*.dart` | Platform-conditional compass stream and permission. |
| `L10n` | `api/l10n/l10n.dart` | Supported locales, language names, first-visit language. |
| `SiteContact` | `config/site_contact.dart` | Public contact details for the legal pages. |
| `SitePagesContent` | `data/site_pages_content.dart` | Text of About / Accessibility / Privacy per language. |

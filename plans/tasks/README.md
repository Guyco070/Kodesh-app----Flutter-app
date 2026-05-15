# Kodesh App - Sprint Planning

This folder contains sprint task files organized for Monday.com import.

## Sprint Organization

### Sprint 1: Critical Fixes (Week 1)
**Priority:** P0 - Must fix before production
- Provider initialization bugs
- SharedPreferences parameter errors
- Locale dropdown bug
- API error handling
- Chol HaMoed testing
- Notification permissions

**Total Estimated Hours:** 17 hours

---

### Sprint 2: Notifications (Week 2-3)
**Priority:** P1-P2 - Core functionality
- Tefilin on Chol HaMoed logic
- Background notification handler
- Hanukkah translations
- Exact alarm permissions
- Rosh Chodesh edge cases
- Notification retry logic
- Input validation
- Preview & test features

**Total Estimated Hours:** 35 hours

---

### Sprint 3: Code Quality (Week 4-5)
**Priority:** P1-P2 - Technical debt reduction
- Refactor large methods
- Replace print with logging
- Remove commented code
- Fix helper functions
- Remove magic strings
- Fix typos
- Standardize naming
- Reduce widget nesting
- Improve type safety
- Remove dead code
- Fix TODOs

**Total Estimated Hours:** 47 hours

---

### Sprint 4: Testing (Week 6-7)
**Priority:** P1 - Essential for quality
- Unit tests for notifications
- Unit tests for event parsing
- Unit tests for date calculations
- Widget tests
- Integration tests
- Test coverage reporting
- Mock data creation

**Total Estimated Hours:** 54 hours

---

### Sprint 5: Architecture (Week 8-10)
**Priority:** P2 - Foundation improvements
- Remove static state
- Fix circular dependencies
- Repository pattern
- Dependency injection
- Error boundaries
- Separate concerns
- State management upgrade

**Total Estimated Hours:** 71 hours

---

### Sprint 6: Functionality (Week 11-12)
**Priority:** P1-P2 - User-facing improvements
- Offline mode with caching
- Error messages
- Hebrew date range fix
- API error handling
- Response validation
- Timezone validation
- Connection handling
- Loading states
- Retry buttons
- Language change optimization

**Total Estimated Hours:** 61 hours

---

### Sprint 7: Performance (Week 13)
**Priority:** P2-P3 - Optimization
- Cities list optimization
- Image caching
- Widget rebuild optimization
- Performance profiling
- App size reduction

**Total Estimated Hours:** 28 hours

---

### Sprint 8: DevOps (Week 14-16)
**Priority:** P2-P3 - Infrastructure
- Crash reporting
- Analytics
- .gitignore fixes
- Clean generated files
- CI/CD pipeline
- Beta testing setup
- Version management
- Release notes
- Build standardization
- Flavor support

**Total Estimated Hours:** 46 hours

---

### Sprint 9: i18n & Accessibility (Week 17-19)
**Priority:** P3 - Inclusive design
- Complete Spanish translation
- Complete Russian translation
- RTL validation
- Language onboarding
- Translation management
- Semantic labels
- Screen reader testing
- High contrast mode
- Font scaling tests
- Keyboard navigation
- Color blind support

**Total Estimated Hours:** 64 hours

---

### Sprint 10: Documentation (Week 20-21)
**Priority:** P2-P3 - Knowledge sharing
- Dartdoc comments
- Complex logic documentation
- Architecture docs
- README
- API documentation
- ADRs
- Contribution guidelines
- Code of conduct
- Changelog

**Total Estimated Hours:** 51 hours

---

### Sprint 11: Security & Privacy (Week 22-24)
**Priority:** P3 - Compliance
- Privacy policy
- Data encryption
- Permissions documentation
- Security audit
- GDPR compliance

**Total Estimated Hours:** 33 hours

---

### Sprint 12: Data Management (Week 25-27)
**Priority:** P3 - Data layer
- Database implementation
- Data migration strategy
- Export/import feature
- Settings model

**Total Estimated Hours:** 34 hours

---

### Sprint 13: Features - Prayers (Week 28-32)
**Priority:** P3 - Enhancements
- Custom checklist tasks
- Reorderable checklist
- Custom notifications
- Scheduling preview
- City sync
- Notification history
- Sound/vibration customization
- Notification grouping
- Smart timing
- Tefillot expansion
- Transliteration
- English translations
- Prayer notes
- Prayer history
- Daily learning

**Total Estimated Hours:** 144 hours

---

### Sprint 14: Features - UI (Week 33-38)
**Priority:** P3 - User experience
- Home screen widget
- Share feature
- Location auto-detection
- Multiple locations
- Custom zmanim
- Zmanim widget
- Prayer time notifications
- Theme support
- Font controls
- Date formats
- Sound effects

**Total Estimated Hours:** 100 hours

---

### Sprint 15: Features - Advanced (Week 39-50)
**Priority:** P3 - Future vision
- User accounts
- Cloud sync
- Community features
- Shul finder
- Watch apps
- Voice assistant
- Calendar integration
- Contact integration

**Total Estimated Hours:** 156 hours

---

## Import Instructions for Monday.com

1. **Create a new board** in Monday.com for "Kodesh App Development"

2. **Import each CSV file** as a separate group/sprint:
   - Go to your board
   - Click on the three dots menu
   - Select "Import data"
   - Choose "From CSV"
   - Upload the sprint CSV file
   - Map the columns:
     - Name → Item Name
     - Status → Status column
     - Priority → Priority column
     - Notes → Long Text column (contains Type, Description, File Location, and Estimated Hours in format: [Type] Description | File: path | Est: Xh)

3. **Customize your board**:
   - Add a Timeline column for sprint dates
   - Add an Owner column for assignment
   - Add a Progress column (0-100%)
   - Add a Dependencies column
   - Create automation for status changes
   - Set up sprint views

4. **Priority Color Coding**:
   - Critical = Red
   - High = Orange
   - Medium = Yellow
   - Low = Green

## Recommended Sprint Duration
- **Sprints 1-3:** 2-week sprints (Critical path)
- **Sprints 4-12:** 2-3 week sprints (Foundation)
- **Sprints 13-15:** 4-6 week sprints (Feature development)

## Total Project Estimation
- **Total Tasks:** 150+
- **Total Hours:** ~941 hours
- **Estimated Duration:** 12-18 months with 1-2 developers
- **Recommended Team:** 2-3 developers + 1 QA

## Notes
- Sprint order is based on dependencies and priorities
- Adjust timelines based on team capacity
- Some sprints can run in parallel (e.g., Docs + Features)
- Regular sprint reviews recommended every 2 weeks

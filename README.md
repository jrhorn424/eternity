versioning-demo
===============

This sample rails app demonstrates how one might version a business object
using polyglot persistence.

There are several choices available for our versioning store:

  - Graph database: store diffs between data, similar to how git works. Cheap
    storage, cheap logic. Adapters may be available for Ruby.
  - Transaction log: store stupid diffs, use application logic to reconstruct
    versions. Expensive storage, expensive logic. Build-it-yourself.
  - Datomic: hybrid of the previous two, but requires jruby.
  - Document store: serialize entire versions and store them. Expensive storage,
    cheap logic. Works with ActiveRecord and other ORMs.

At a high level, the app uses relational data where appropriate, and a document
store for versioned persistence.

|            | Create                                | Read                                  | Update                                | Delete                                                   |
| ---------- | ------                                | ----                                  | ------                                | ------                                                   |
| Relational | `def create`                          | `def show; def index`                 | `def update`                          | `def destroy`                                            |
| Document   | `after_submit :serialize_new_version` | `def show_version; def version_index` | `after_submit :serialize_new_version` | `before_destroy :serialize_new_version`, paranoid delete |
| Graph      |                                       |                                       | `after_update :serialize_diff`        | `before_destroy :serialize_diff`, paranoid delete        |

Acceptance Criteria
-------------------

  - Show a current and most recent previous version of the business object
    (Versionable)
  - Have the ability to persist but abandon a draft change (Draftable)
  - Audit changes (Auditable)

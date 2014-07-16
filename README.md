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

Summary Plan
------------

  - Two databases, or tables, one for claim version *n*, one for *n+1*
    (drafts).
    - Identical schemas for both.
    - Primary key id and draft id for both.
  - On edit, the object is persisted to draft workspace.
  - Schema changes happen in both.
  - On submit, the draft object is "copied" back to the primary workspace.
  - On both submit and delete, the draft object is deleted.
  - Claim version *n-1...1* (historical versions) are stored in a document
    store.

Open Questions
--------------

  - Do we utilize tables or databases for drafts?
    - Using tables has the benefits of:
      - Single connection.
      - Minimizes ops management responsibilities.
    - Usiing tables has the costs of:
      - Multiplication or compilication of migrations and retros.
      - Drafts are visible to reporting.
    - Using databases has the benefits of:
      - Simple migrations.
      - Drafts are hidden from reporting.
    - Using databases has the costs of:
      - Multiple connections.
      - Complicating ops management (security, work processes).
  - Where do we wire up the "switches" in ActiveRecord/ActiveModel?
  - What happens if we break persistence out of ActiveRecord pattern, and
    instead adopt a DataMapper pattern?

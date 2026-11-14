# Review examples

Short comments in the voice this skill uses. They are illustrations of priority and
tone, not a transcript of one person's reviews. Product-specific state libraries,
session replay, and internal analytics event names are left out on purpose.

---

## Coupling & Fragility

### Index-based coupling

> **Fragile index-based coupling** — `columnLoadingStates[colIndex]` only works because
> `GRID_COLUMNS` and this array happen to be in the same order. If someone reorders
> columns or adds one, the loading indicators silently break with no type error.
>
> A map keyed by `kind` would be self-documenting and order-independent:
> ```typescript
> const loadingByKind: Record<GridItemKind, boolean> = {
>     dashboard: dashboardsLoading,
>     recent: recentItemsLoading,
>     starred: starredItemsLoading,
> }
> ```
> Then `loadingByKind[col.kind]` in the JSX.

### DOM selector coupling

> **DOM querySelector coupling** — `SearchInput` reaches into the grid via
> `document.querySelector('[data-attr="result-grid"]')` and the grid reaches back
> via `document.querySelector('#search-input')`. Two components talking through global
> DOM selectors is brittle — if either attribute changes, the other breaks silently.
>
> A ref through context, or an explicit `focusInput` / `focusGrid` action, would
> make this coupling explicit, type-safe, and discoverable.

### Circular dependencies

> feels wrong to have something in lib/components depend on the app shell

> (not a strong opinion since this wouldn't be the first circular dependency in the app)

> this import was complaining about circular dependencies so i lazied it up

### Mocks diverging from prod

> Ah, the joy of mocks

---

## Observability & Safe Rollouts

### Measure before you limit

> so is this actually doing the rate limiting? in adding other new rate limiters elsewhere
> we've more than once had the situation where we've got the condition wrong and regretted it
>
> in those cases we've always wished that we'd had a release that only logged that it
> _would_ have limited or been easily able to turn off the limiting
>
> should we just increment and log here and then see whether we would have limited?

> i guess at first i'd do nothing here... just count, so we can run a graph
> and see what happens
>
> we can start dropping at peaks but every dropped message is work we cannot recover
> so if we get the limiting wrong then we'll drop too much and make pain for ourselves
>
> so, captain abundance of caution here would just graph it and then see what the what

### Data-attrs for analytics

> let's stick a data-attr on this button and input
>
> it lets us find it in analytics later, e.g. a funnel from changing the input to not
> clicking update, to see if that's happening

### Feature flags & Knight Capital

> why not re-use flags? the canonical example is https://specbranch.com/posts/knight-capital/
>
> (in reality it's fine)

### Configurable thresholds

> fair... i don't think so, but i don't know so
> made it 50k and made it configurable and measurable

### Cache headers

> could we set an immutable cache header here? once we've sent this blob it will not
> change, so the client is free to cache it forever, right?

---

## Naming & Readability

### Boolean inversions

> nit picking that we're using noBorder and noPadding as their opposites
>
> e.g. `!noBorder` or `noBorder ? '' : ...`
>
> so we could flip them and make the code _slightly_ easier to read
> but very not blocking

### Confusing ternaries

> very nitpicky that these two ternary props are opposites
>
> e.g. `condition ? null : component` then `condition ? component : undefined` made me
> have to think when parsing...
>
> should they mirror each other more?

### Misleading names

> should this be `allowCompactDisplay` or something. it reads like it tells you if the card
> viewport is compact
> (nit picking, though, feel free to disagree)

### Copy clarity

> Should the label be "Deployments" or "Airflow deployments"?
> make it really easy to understand what the choice is

### Magic values

> nit picking... an explanation of the character codes would help the future traveller
> (or at least i've never memorised them)

---

## Composed Method / Long Components

### Long component

> **Long Method** — `ResultGrid` is long, with mixed abstraction levels: skeleton
> persistence, keyboard navigation state, a large keydown handler, column rendering
> with a 3-way conditional, and inline context menus.
>
> ComposedMethod suggestion — consider extracting:
> - A `GridColumn` component for the loading/empty/items rendering
> - A `useGridKeyboardNav(columns, onSelect)` hook for the keyboard handler — it's
>   self-contained logic that would let the grid focus on layout
>
> Each piece becomes independently testable, and the component reads like a table of contents.

### Deeply nested inline JSX

> **Deeply nested inline JSX** — this `extraContextMenuItems` prop contains two full
> JSX branches with event handlers, analytics capture, and conditional rendering — all
> inline inside a `.map()` inside a ternary.
>
> Extracting a small function like `getGridItemContextMenu(item, { ... })` would flatten
> the nesting and keep the column rendering scannable.

---

## Type System Over Constants

> i've tightened the typing so that activeTabKey is no longer a string which means this
> is a literal `'metrics'` (i'm slightly allergic to extracting constants when the type
> system could protect us instead)

---

## API Design Empathy

### Accept all reasonable inputs

> really silly question... why not accept both?
> we have a situation where we'd like the clients to be similar but they're not
> a caller is going to mix them up
> just have them all accept all the options

### Clearer prop APIs

> is it worth this being something like `openAs: 'modal' | 'tab'`
> to make it clearer what the behaviour is?

### Version-aware lazy loading

> once the entry file loads it starts requesting lazy chunks
>
> it would be awesome if those chunks were pinned to the same version as the entry
>
> one of the problems we have is that folk publish a new version without realising
> there's a breaking change between the entry file and a lazy-loaded chunk

---

## Security at Boundaries

> can you add tests that an API token can still access the endpoints
> (so we don't break callers in future)
>
> if there aren't any already then we should add tests that a user in workspace A can't
> get data in workspace B. when we open the API up to external access the threat ratchet
> goes one higher

---

## Dead Code

> **Dead selector** — this used to depend on hover state (removed in this change), so it
> was a selector. Now it is a function with zero inputs returning a constant.
>
> This can just be a plain constant or removed entirely and inlined at the one call site.
> The selector machinery isn't buying anything anymore.

> are you near to removing this flag?

---

## Parameterized Tests

> these cases are the same assertion with different inputs. please parameterise them.

---

## Thinking Out Loud

### Walking through a sequence

> so the sequence i'd expect is
>
> * worker goes idle
> * a new run id is assigned
> * worker comes back
> * it should pick up the new run id and restart
>
> i wonder why not
>
> which i guess is a long way of saying i wonder if we can handle this in one place
> to avoid having to think about several

### Changing mind mid-review

> actually ignore me. i think i'm chasing my tail

> second thoughts it makes me wonder what would happen if we searched for the short name
> and the fully qualified name
> they should probably match all present, and only an explicit key should match the exact item

### Honesty when the read was wrong

> how silly, obviously this file lives in this pr

> really silly i didn't read the code question
> how do we know this is an external caller at this point?

> total tangent... i wonder if we have to wait for the reload before we navigate and
> it makes things feel slow without a spinner

---

## Generous Approvals

> high trust

> low context, high trust review :)

> stamp anyway, just a comment on naming

> low context for hotfix

> didn't run it. couple of questions but ship as you see fit

> the robot has thoughts but....

> 1 word change, 48 comments

---

## Questioning Over Demanding

> silly question... since the session max is (today) 24 hours — why 48?

> doesn't matter that we've lost an auth check around this organisation name?

> have we lost this reload behaviour completely?

> is this change necessary?

> is this existing copy pasta? that data attr looks wrong for this...

> are we sure this logic is safe outside the app shell?

> are we _certain_ the worker is going idle, so we're actually exercising the new restart?

---

## Trading Off Pragmatically

> aren't we purposefully trading money for time though
>
> we're paying for the faster runners because they're faster
>
> why do we need the runner change and the base-image change in the same pull request?

> fine for an experiment but this makes at least 6 API calls to load a list of 5 people...
> there must be a better way :)

> i was going to suggest just showing the description or not based on the container... but
> someone _did_ spend the time adding one so it makes sense to let them choose if it
> should be visible. nice

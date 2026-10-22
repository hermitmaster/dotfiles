import { Plugin, usePlugin } from "@opencode/plugin/tui"
import { Show } from "solid-js"

function Branch() {
  const context = usePlugin()
  const branch = () => {
    const location = context.location ?? context.data.location.default()
    return context.data.location.vcs.info(location)?.branch.current
  }
  return (
    <Show when={branch()}>
      <text fg={context.theme.text.muted}>{` ${branch()}`}</text>
    </Show>
  )
}

export default Plugin.define({
  id: "local.statusline",
  async setup(context) {
    const location = context.location ?? context.data.location.default()
    await context.data.location.vcs.sync(location)

    return context.ui.slot({
      append: "home.footer.status",
      render: () => <Branch />,
    })
  },
})

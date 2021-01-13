Start the Phoenix server `iex -S mix phx.server`

Visit localhost:4000 in the browser

From iex, query to see what user sessions are connected

`iex(3)> Registry.lookup(Subpub.Tracker.Registry, "user_sockets")`

This should return a list of pids and session ids like so

`[{#PID<0.577.0>, "d3d7a8cb-c1f9-41c7-b16e-1b3b39417eb5"}]`

Notice that if you navigate away from the app the connection is removed

`iex(4)> Registry.lookup(Subpub.Tracker.Registry, "user_sockets")`

`[]`

The purpose of this exercise is to offer a solution that returns active user socket connections

I used this to migrate away from `Phoenix.PubSub.Local.list` during a phx 1.4 => 1.5 upgrade

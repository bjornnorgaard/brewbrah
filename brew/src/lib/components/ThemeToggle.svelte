<script lang="ts">
	import { Moon, Sun } from '@lucide/svelte';
	import { onMount } from 'svelte';

	let dark = $state(false);

	onMount(() => {
		dark = document.documentElement.classList.contains('dark')
			? true
			: document.documentElement.classList.contains('light')
				? false
				: matchMedia('(prefers-color-scheme: dark)').matches;
	});

	function toggle() {
		dark = !dark;
		const root = document.documentElement;
		root.classList.toggle('dark', dark);
		root.classList.toggle('light', !dark);
		try {
			localStorage.setItem('brew:theme', dark ? 'dark' : 'light');
		} catch {
			/* ignore */
		}
	}
</script>

<button
	type="button"
	class="btn-icon size-11 transition-transform hover:preset-tonal active:scale-90"
	aria-label={dark ? 'Switch to light theme' : 'Switch to dark theme'}
	onclick={toggle}
>
	{#key dark}
		<span class="inline-flex animate-[spin_0.4s_ease-out]">
			{#if dark}<Sun size={20} />{:else}<Moon size={20} />{/if}
		</span>
	{/key}
</button>

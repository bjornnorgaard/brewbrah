<script lang="ts">
	import { Moon, Sun } from '@lucide/svelte';
	import { onMount } from 'svelte';

	let dark = $state(false);

	/** The user's explicit choice, if any. Otherwise we follow the OS. */
	function stored(): 'dark' | 'light' | null {
		try {
			const t = localStorage.getItem('brew:theme');
			return t === 'dark' || t === 'light' ? t : null;
		} catch {
			return null;
		}
	}

	onMount(() => {
		const mq = matchMedia('(prefers-color-scheme: dark)');
		const sync = () => {
			const choice = stored();
			dark = choice ? choice === 'dark' : mq.matches;
		};
		sync();
		// Live-follow the OS (e.g. automatic sunset switching) while no explicit choice is saved.
		mq.addEventListener('change', sync);
		return () => mq.removeEventListener('change', sync);
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

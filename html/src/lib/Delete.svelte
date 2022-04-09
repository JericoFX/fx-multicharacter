<script lang="ts">
	import {fade} from 'svelte/transition';
	import {createEventDispatcher} from 'svelte';
	const dispatch = createEventDispatcher();
	export let open = false;
	const closeModal = () => {
		open = false;
		dispatch('Close', {open});
	};
</script>

{#if open}
	<div class="modal-overlay" transition:fade={{duration: 100}}>
		<div class="my-back fit" />
		<div class="modals absolute-center">
			<button on:click={closeModal} class="btn fixed-bottom" style="left:43%">Close</button>
		</div>
	</div>
{/if}

<style>
	.modals {
		position: absolute;
		width: 537px;
		height: 245px;
		background: rgba(25, 25, 33, 0.96);
		box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.59);
		border-radius: 10px;
	}
	.my-back {
		background-color: rgba(255, 255, 55, 0.0001) !important;
	}
	.modal-overlay {
		z-index: 1000;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: #00000080 !important;
	}
</style>

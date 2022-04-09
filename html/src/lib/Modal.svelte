<script lang="ts">
	import {fade} from 'svelte/transition';
	import {createEventDispatcher} from 'svelte';
	const dispatch = createEventDispatcher();
	export let open = false;
	export let message = '';
	const closeModal = () => {
		open = false;
		dispatch('Close', {open});
	};
</script>

{#if open}
	<div class="modal-overlay " transition:fade={{duration: 100}}>
		<div class="my-back fit" />
		<div class="modals absolute-center">
			<p class="characters-register-block-header absolute-center text-capitalize	">
				{message}
			</p>
			<div class="closebutton absolute-center" on:click={closeModal}>
				<p class="absolute-center">Close</p>
			</div>
		</div>
	</div>
{/if}

<style>
	.modals {
		position: absolute;
		width: 20%;
		height: 10%;
		background: rgb(23 23 23 / 80%);
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
	.closebutton {
		margin-top: 25px;
		margin-right: 7.5%;
		z-index: 999;
		width: 12.5%;
		height: 20%;
		color: #ededed;
		background-color: #dc143c;
		font-size: 1.3vh;
		font-weight: 900;
		border-radius: 0.3vh;
		cursor: pointer;
		padding: 0.3vh;
	}
	.characters-register-block-header {
		width: 100%;
		text-align: center;
		height: 10vh;
		color: #ededed;
		font-size: 2vh;
		font-weight: 300;
	}
</style>

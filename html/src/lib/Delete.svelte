<script lang="ts">
	import {fade} from 'svelte/transition';
	import {createEventDispatcher} from 'svelte';
	const dispatch = createEventDispatcher();
	export let open = false;

	const closeModal = (desicion: boolean) => {
		open = false;
		dispatch('closeModalDelete', {desicion});
	};
</script>

{#if open}
	<main in:fade={{delay: 600, duration: 500}} out:fade={{duration: 500}}>
		<div class="modal-overlay">
			<div class="my-back fit" />
			<div class="modals absolute-center">
				<div class="character-delete absolute-center">
					<div class="characters-delete-block-header">
						<p>Delete Character</p>
					</div>

					<p>Are You Sure You Want To Delete This Character?</p>

					<div class="character-acceptdel-btn" id="accept-delete"><p id="accept-text" on:click={() => closeModal(true)}>Confirm</p></div>
					<div class="character-canceldel-btn" id="cancel-delete"><p id="cancel-text" on:click={() => closeModal(false)}>Return</p></div>
				</div>
			</div>
		</div>
	</main>
{/if}

<style>
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
	.character-delete {
		position: absolute;
		width: 33vh;
		height: 19vh;
		background-color: rgb(23 23 23 / 80%);
		border-radius: 0.8vh;
		padding: 30px;
		font-family: 'Poppins', sans-serif;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		color: #ededed;
		font-family: 'Poppins', sans-serif;
		overflow: visible !important;
	}

	.characters-delete-block-header {
		position: absolute;
		width: 100%;
		height: 11%;
		color: #ededed;
		text-align: left;
		font-size: 2vh;
		line-height: 29px;
		font-family: 'Poppins', sans-serif;
		font-weight: 900;
		text-transform: uppercase;
		overflow: visible !important;
	}

	.characters-delete-block-header > p {
		font-family: 'Poppins', sans-serif;
		overflow: visible !important;
	}

	.character-delete > p {
		padding-top: 50px;
		font-size: 1.3vh;
		overflow: visible !important;
	}

	.character-acceptdel-btn {
		position: absolute;
		width: 43%;
		height: 19%;
		bottom: 0;
		left: 5%;
		margin-bottom: 20px;
		background-color: #28a745;
		border-radius: 4px;
		transition: 0.2s;
		overflow: visible !important;
		cursor: pointer;
	}

	.character-canceldel-btn {
		position: absolute;
		width: 43%;
		height: 19%;
		bottom: 0;
		right: 5%;
		margin-bottom: 20px;
		background-color: #dc143c;
		border-radius: 4px;
		transition: 0.2s;
		overflow: visible !important;
		cursor: pointer;
	}

	.character-acceptdel-btn > p {
		color: #ededed;
		text-align: center;
		padding-top: 1vh;
		font-family: 'Poppins', sans-serif;
		overflow: visible !important;
		font-weight: 900;
		text-transform: uppercase;
	}

	.character-canceldel-btn > p {
		color: #ededed;
		text-align: center;
		padding-top: 1vh;
		font-family: 'Poppins', sans-serif;
		overflow: visible !important;
		font-weight: 900;
		text-transform: uppercase;
	}
</style>

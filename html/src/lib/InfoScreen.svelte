<script lang="ts">
	import {createEventDispatcher} from 'svelte';
	import {fade, fly} from 'svelte/transition';
	export let open = false;
	export let data = [];
	const dispatch = createEventDispatcher();

	function closeModal() {
		open = false;
		dispatch('closeModal', {});
	}
</script>

{#if open}
	<div>
		<div class="my-back">
			<div class="modal-overlay ">
				<div class="character-info absolute-right" in:fly={{y: 200, duration: 2000}} out:fade>
					<div id="char-info-titel" class="absolute-center full-width" style="top:10%;left:53%">
						<span>Character Information</span>
					</div>
					<div class="character-info-box full-width" style="left:5%;top:15%;">
						<p class="on-left">
							Name: <span class="float-right">{data[0].charinfo.firstname}</span>
						</p>
						<p class="on-left">
							Last Name: <span class="float-right">{data[0].charinfo.lastname}</span>
						</p>
						<p class="on-left">
							Job: <span class="float-right">{data[0].job.name}</span>
						</p>
						<p class="on-left">
							Rank: <span class="float-right">{data[0].job.label}</span>
						</p>
						<p class="on-left">
							Cash: <span class="float-right"> ${data[0].money.cash}</span>
						</p>
						<p class="on-left">
							Bank: $<span class="float-right">${data[0].money.bank}</span>
						</p>
					</div>
					<div class="close absolute-center" on:click={closeModal}>
						<span>Close</span>
					</div>
				</div>
			</div>
		</div>
	</div>
{/if}

<style>
	:global() {
		font-family: 'Poppins', sans-serif;
	}
	.close {
		width: 15%;
		height: 5%;
		top: 90%;
		margin-left: 4%;
		margin-bottom: 1%;
		text-align: center;
		background-color: #dc143c;
		font-family: 'Poppins', sans-serif;
		font-weight: 600;
		border-radius: 0.8vh;
		cursor: pointer;
	}
	.character-info {
		position: absolute;
		width: 20%;
		height: 50%;
		top: 25%;
		margin-right: 10px;
		max-height: 100vh;
		border-radius: 0.8vh;
		padding: 30px;
		background-color: rgb(23 23 23 / 80%);
		overflow: visible !important;
	}
	#char-info-titel {
		text-transform: uppercase;
		position: absolute;
		font-family: 'Poppins', sans-serif;
		font-size: 2.5vh;
		color: #ededed;
		letter-spacing: 0.1vh;
		font-weight: 900;
		overflow: visible !important;
	}
	.character-info-box {
		position: relative;
		color: #ededed;
		font-size: 1.5vh;
		width: 100%;
		font-family: 'Poppins', sans-serif;
		height: 2.9vh;
		font-weight: 900;
		text-transform: uppercase;
		margin-bottom: 12px;
	}
	p {
		font-size: 20px;
		font-weight: 600;
		-webkit-font-smoothing: subpixel-antialiased;
	}
	p span {
		font-size: 16px;
		font-style: italic;
		font-weight: 300;
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

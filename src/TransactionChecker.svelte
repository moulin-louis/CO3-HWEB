<script>

    const GR_PER_TX = 2.5; //source: https://tezos.com/carbon/
    export let nbr_tx;
    export let co2_emit;
    export let user_check;
    export let walletHandler;
    let status = true;

    const fetchTransactionsCount = async () => {
        try {
            const address = await walletHandler.getPKH();
            const url = `https://api.ghostnet.tzkt.io/v1/accounts/${address}/operations`;
            const response = await fetch(url);

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const data = await response.json();
            co2_emit = data.length * GR_PER_TX; // Assuming GR_PER_TX is a predefined constant
            status = false; // Assuming 'status' is a variable you want to set to false upon successful fetch
            return data.length;
        } catch (e) {
            console.error("error occurred when fetching tx: ", e);
        }
    };

    const handleSubmit = async () => {
        nbr_tx = await fetchTransactionsCount();
    };

    const handleClick = () => {
        user_check = true;
    };
</script>

<div style="text-align: center;">

    {#if status}

        <button class="custom-button impact-button" on:click={handleSubmit}>Check your impact!</button>

    {/if}
    {#if !status}
        <p>You have processed {nbr_tx} transactions for a total of {co2_emit}g of CO2.</p>
        <button class="custom-button" on:click={handleClick}>Neutralize your environmental impact!</button>
    {/if}
</div>


  
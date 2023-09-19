import express from 'express';
import bodyParser from 'body-parser';
import { OneClient, PerformError, UnexpectedError } from '@superfaceai/one-sdk';
import { config } from 'dotenv';

config();

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());

const client = new OneClient({
    // The token for monitoring your Comlinks at https://superface.ai
    token: process.env.SUPERFACE_ONESDK_TOKEN,
    // Path to Comlinks within your project
    assetsPath: './superface'
});

const comlinkProfile = await client.getProfile('email-communication/email-sending');
const useCase = comlinkProfile.getUseCase('SendEmail');

app.post("/execute", async (req, res) => {
    // Input values from request body
    let inputs = req.body;

    try {
        // Execute use case
        const result = await useCase.perform(inputs,
            {
                provider: 'resend',
                parameters: {},
                // Security values for provider
                security: { bearerAuth: { token: process.env.RESEND_TOKEN } }
            }
        );

        res.send(result);
        console.log("RESULT:", JSON.stringify(result, null, 2));

    } catch (e) {
        if (e instanceof PerformError) {
            res.send(e.errorResult);
            console.log('ERROR RESULT:', e.errorResult);
        } else if (e instanceof UnexpectedError) {
            res.status(500).send(e);
            console.error('ERROR:', e);
        } else {
            res.status(500).send(e);
            throw e;
        }
    }
});

app.listen(port, () => console.log(`Listening on port ${port}!`));

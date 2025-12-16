# HSCurrencyExchangeDemo
HSCurrencyExchangeDemo is a Business Central AL demo extension that synchronizes foreign exchange rates from an external REST API into Microsoft Dynamics 365 Business Central.

The project demonstrates AL development patterns, including:

REST API consumption (HttpClient)

JSON parsing (JsonObject, JsonToken)

Background processing (Job Queue)

Logging and monitoring

API Pages (read-only REST exposure) -> to be implemented in progress

Clean modular architecture

This repository is intended as a portfolio project showcasing production-style like Business Central development.

🎯 Features

🔄 Fetch Exchange rates from an external REST API

🧠 Parse and validate JSON responses

📥 Store rates in Business Central

🕒 Run automatically via Job Queue

📊 Log all executions (success & error)

🌐 Expose data via Business Central API pages

🔐 OAuth2-secured API access (AAD)

🧱 Architecture Overview -> in progress

🚀 How to Run

Publish the extension to Business Central

Open EX Sync Setup

Configure:

API URL

Base Currency

Currencies to Sync (comma-separated)

Enable synchronization

Click Sync Now or schedule via Job Queue

Review results in EX Log

🛠 Still To Be Done (Planned Improvements)

This project is intentionally left extensible.
The following enhancements are planned:

✅ Finish the App

🧪 Automated Tests

Unit tests for JSON parsing

Integration tests for Exchange sync

Error-scenario test coverage

AL Test Toolkit usage

🔁 CI/CD (GitHub Actions)

Automated build on push

AL compilation in container

Automated test execution

Artifact publishing (.app)

Status badges in README

(CI/CD will be implemented using GitHub Actions, not Azure DevOps which I currently use on job.)

📌 Why This Project?

This project exists to demonstrate Business Central AL skills, including:

Integration development

Backend automation

API design

Production-style architecture

Testing & DevOps readiness

It goes beyond simple table/page extensions and reflects real-world BC customization work.

👤 Author

Hrvoje Šuta
Business Central Developer
Focus: AL development, integrations, automation, testing

📄 License

This project is provided for demonstration and educational purposes.




# RUNBOOK – Langkah untuk siapkan Task 1–33

Jalankan arahan ni dalam **lab environment IBM Skills Network** (Cloud IDE dengan OpenShift).
Setiap fail output (`rest-create-done`, `kube-images` dan lain-lain) akan terhasil bila kau jalankan arahan tu.
Lepas tu buka fail, copy isinya, dan paste ke dalam jawapan Coursera.

> Gantikan `amrasy9am-sudo` jika username GitHub berbeza.

---

## 0. Clone repo dan setup (sekali sahaja)

Repo `devops-capstone-project` dah ada dalam GitHub dengan semua kod. Dalam terminal lab:

```bash
cd /home/project
git clone https://github.com/amrasy9am-sudo/devops-capstone-project.git
cd devops-capstone-project
git config --global user.name "Mohamad Amirul Asyraf"
git config --global user.email "amrasy9am@gmail.com"
```

Untuk `git push` dari lab, guna **Personal Access Token** sebagai password.

Setup environment:

```bash
bash bin/setup.sh
exit          # buka terminal baru selepas ini
cd /home/project/devops-capstone-project
```

---

## 1. Agile Planning (Task 2–6)

**Task 2:** `https://github.com/amrasy9am-sudo/devops-capstone-project/blob/main/.github/ISSUE_TEMPLATE/user-story.md`

Buat GitHub Project (Board) dengan lajur: **New Issues, Icebox, Product Backlog, Sprint Backlog, In Progress, Review/QA, Done**.

Buat issue untuk setiap story dalam `docs/user-stories.md` (guna template **User Story**).

| Screenshot | Apa yang kena tunjuk |
|---|---|
| `planning-userstories-done.png` (Task 3) | Semua story dalam lajur **New Issues** |
| `planning-productbacklog-done.png` (Task 4) | Story 7, 8, 9 dalam **Icebox**; story 1–6 dalam **Product Backlog** |
| `planning-labels-done.png` (Task 5) | Label `technical debt` dan `enhancement` pada story dalam Product Backlog |
| `planning-kanban-done.png` (Task 6) | Story 1–6 dalam **Sprint Backlog**, setiap satu ada **Estimate** dan **Iteration/Milestone = Sprint 1** |

---

## 2. RESTful service (Task 7–17)

**Task 7:** `https://github.com/amrasy9am-sudo/devops-capstone-project/blob/main/setup.cfg`

Jalankan test:

```bash
nosetests
```

Mulakan service dalam **Terminal 1**:

```bash
honcho start
```

Dalam **Terminal 2**, jalankan arahan ni satu-satu. Setiap arahan simpan command dan output ke dalam fail.

> Header `X-Forwarded-Proto: https` diperlukan sebab Flask-Talisman paksa HTTPS (tanpa header, service akan balas 302 redirect).

```bash
cd /home/project/devops-capstone-project
H="X-Forwarded-Proto: https"

# Task 13 – CREATE
(set -x; curl -i -X POST http://127.0.0.1:5000/accounts \
  -H "$H" -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@doe.com","address":"123 Main St.","phone_number":"555-1212"}') > rest-create-done 2>&1

# Task 14 – LIST
(set -x; curl -i -X GET http://127.0.0.1:5000/accounts -H "$H") > rest-list-done 2>&1

# Task 15 – READ
(set -x; curl -i -X GET http://127.0.0.1:5000/accounts/1 -H "$H") > rest-read-done 2>&1

# Task 16 – UPDATE
(set -x; curl -i -X PUT http://127.0.0.1:5000/accounts/1 \
  -H "$H" -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@doe.com","address":"456 New St.","phone_number":"555-1111"}') > rest-update-done 2>&1

# Task 17 – DELETE
(set -x; curl -i -X DELETE http://127.0.0.1:5000/accounts/1 -H "$H") > rest-delete-done 2>&1

cat rest-*-done
```

> Kalau ID bukan `1` (contoh: database dah ada data), tukar `/accounts/1` ikut `id` dalam output CREATE.

Pindahkan story ke **Done** dan ambil screenshot:

| Screenshot | Story dalam Done |
|---|---|
| `rest-techdebt-done.png` (Task 8) | Setting up the development environment |
| `read-accounts.png` (Task 9) | Read an account from the service |
| `list-accounts.png` (Task 10) | List all accounts in the service |
| `update-accounts.png` (Task 11) | Update an account in the service |
| `delete-accounts.png` (Task 12) | Delete an account from the service |

Hentikan `honcho` dengan `Ctrl+C`.

---

## 3. CI dengan GitHub Actions (Task 1, 18–21)

1. Pindahkan story 10 dan 11 ke **Sprint Backlog** (Sprint 2). Ambil screenshot → **`sprint2-plan.png` (Task 18)**.
2. Workflow dah ada dalam `.github/workflows/ci-build.yaml`. Buat satu PR supaya ia run:

```bash
git checkout -b add-ci-build
echo "" >> README.md
git commit -am "Trigger CI Build workflow"
git push -u origin add-ci-build
```

3. Di GitHub: **Compare & pull request → Create pull request**. Tunggu tanda hijau, kemudian **Merge**.
4. **Task 19 – `ci-workflow-done`:** Buka tab **Actions → CI Build → run terbaru → job `build`**. Klik ikon ⚙️ → **View raw logs**. Copy semua dan simpan sebagai `ci-workflow-done`. Kalau `gh` CLI ada:

```bash
gh run view $(gh run list --workflow=ci-build.yaml -L 1 --json databaseId -q '.[0].databaseId') --log > ci-workflow-done
```

5. Pindahkan story 10 ke **Done** → **`ci-kanban-done.png` (Task 20)**.

**Task 1:** `https://github.com/amrasy9am-sudo/devops-capstone-project/blob/main/README.md` (badge akan jadi hijau "passing" selepas workflow berjaya)

**Task 21:** `https://github.com/amrasy9am-sudo/devops-capstone-project/blob/main/.github/workflows/ci-build.yaml`

---

## 4. Security headers dan CORS (Task 22–24)

```bash
git checkout main && git pull
nosetests > security-headers-done 2>&1
cat security-headers-done
```

**Task 22:** `https://github.com/amrasy9am-sudo/devops-capstone-project/blob/main/service/__init__.py`

**Task 23:** isi fail `security-headers-done`

Pindahkan story 11 ke **Done** → **`security-kanban-done.png` (Task 24)**.

---

## 5. Docker dan Kubernetes (Task 25–31)

1. Pindahkan story 7, 8, 9 dari Icebox ke **Sprint Backlog** (Sprint 3) → **`sprint3-plan.png` (Task 25)**.

2. Build dan run container:

```bash
docker build -t accounts .
docker run --rm -d --name accounts --link postgresql \
  -e DATABASE_URI=postgresql://postgres:postgres@postgresql:5432/postgres \
  -p 8080:8080 accounts
sleep 5
curl -s -H "X-Forwarded-Proto: https" http://localhost:8080/ > kube-app-output
cat kube-app-output
```

**Task 26 – `kube-app-output`:** output ini ialah `{"name":"Account REST API Service","version":"1.0"}`. Boleh juga buka **Skills Network Toolbox → Launch Application → port 8080** dan copy JSON dari browser.

```bash
docker stop accounts
```

Pindahkan story 7 ke **Done** → **`kube-docker-done.png` (Task 27)**.

**Task 29:** `https://github.com/amrasy9am-sudo/devops-capstone-project/blob/main/Dockerfile`

3. Push image ke IBM Cloud Container Registry:

```bash
docker tag accounts us.icr.io/$SN_ICR_NAMESPACE/accounts:1
docker push us.icr.io/$SN_ICR_NAMESPACE/accounts:1
docker images > kube-images        # Task 30
cat kube-images
```

4. Deploy ke OpenShift:

```bash
oc new-app postgresql-ephemeral
oc describe secret postgresql
sed "s|IMAGE_NAME_HERE|us.icr.io/$SN_ICR_NAMESPACE/accounts:1|" deploy/deployment.yaml | oc apply -f -
oc apply -f deploy/service.yaml
sleep 30
oc get all -l app=accounts > kube-deploy-accounts      # Task 31
cat kube-deploy-accounts
```

Pindahkan story 8 ke **Done** → **`kube-kubernetes-done.png` (Task 28)**.

---

## 6. CD pipeline dengan Tekton (Task 32–33)

```bash
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/flake8/0.1/flake8.yaml
oc apply -f .tekton/workspace.yaml
oc apply -f .tekton/tasks.yaml
oc apply -f .tekton/pipeline.yaml

tkn pipeline start cd-pipeline \
  -p repo-url="https://github.com/amrasy9am-sudo/devops-capstone-project.git" \
  -p branch="main" \
  -p build-image="image-registry.openshift-image-registry.svc:5000/$(oc project -q)/accounts:1" \
  -w name=pipeline-workspace,claimName=pipelinerun-pvc \
  -s pipeline \
  --showlog

tkn pipelinerun logs --last > pipelinerun.txt          # Task 32
tkn pipelinerun ls
cat pipelinerun.txt
```

Pastikan semua task (init, clone, lint, tests, build, deploy) **Succeeded**.

Pindahkan story 9 ke **Done** → **`cd-pipeline-done.png` (Task 33)**.

---

## Senarai semak sebelum hantar

| Task | Jenis | Sumber |
|---|---|---|
| 1 | URL | `README.md` |
| 2 | URL | `.github/ISSUE_TEMPLATE/user-story.md` |
| 3–6 | Screenshot | Kanban board |
| 7 | URL | `setup.cfg` |
| 8–12 | Screenshot | Kanban board |
| 13–17 | Teks | `rest-create-done`, `rest-list-done`, `rest-read-done`, `rest-update-done`, `rest-delete-done` |
| 18 | Screenshot | `sprint2-plan.png` |
| 19 | Teks | `ci-workflow-done` |
| 20 | Screenshot | `ci-kanban-done.png` |
| 21 | URL | `.github/workflows/ci-build.yaml` |
| 22 | URL | `service/__init__.py` |
| 23 | Teks | `security-headers-done` |
| 24–25 | Screenshot | `security-kanban-done.png`, `sprint3-plan.png` |
| 26 | Teks | `kube-app-output` |
| 27–28 | Screenshot | `kube-docker-done.png`, `kube-kubernetes-done.png` |
| 29 | URL | `Dockerfile` |
| 30 | Teks | `kube-images` |
| 31 | Teks | `kube-deploy-accounts` |
| 32 | Teks | `pipelinerun.txt` |
| 33 | Screenshot | `cd-pipeline-done.png` |

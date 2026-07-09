# Como publicar a Pesquisa NPS em pesquisa.freitasconsultoriacontabil.com.br

## 1. Criar o projeto no Supabase (novo, separado do Radar Consultivo)

1. Acesse https://supabase.com e clique em **New Project**
2. Nome sugerido: `freitas-nps`
3. Escolha uma senha de banco forte e a região mais próxima (South America - São Paulo, se disponível)
4. Aguarde o projeto ser criado (leva ~2 min)
5. No menu lateral, vá em **SQL Editor** → **New query**
6. Cole todo o conteúdo do arquivo `schema.sql` e clique em **Run**
   - Isso cria a tabela `respostas_nps` já com as permissões corretas

## 2. Pegar as chaves de API

1. No menu lateral, vá em **Project Settings** → **API**
2. Copie:
   - **Project URL** (algo como `https://xxxxxxxxxxxx.supabase.co`)
   - **anon public key** (uma chave longa que começa com `eyJ...`)

## 3. Configurar o arquivo index.html

1. Abra o arquivo `index.html`
2. No topo do `<script>`, substitua:
   ```js
   const SUPABASE_URL = "COLE_AQUI_A_SUPABASE_URL";
   const SUPABASE_ANON_KEY = "COLE_AQUI_A_ANON_KEY";
   ```
   pelos valores copiados no passo 2.
3. (Opcional, recomendado) Troque a senha de acesso aos resultados:
   ```js
   const ADMIN_CODE = "freitas2026";
   ```

## 4. Subir para o GitHub

1. Crie um repositório novo, por exemplo `pesquisa-nps-freitas`
2. Suba o `index.html` (pode ser só esse arquivo na raiz do repositório)

```powershell
cd caminho\para\pesquisa-nps-freitas
git init
git add index.html
git commit -m "Pesquisa NPS - versao inicial"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/pesquisa-nps-freitas.git
git push -u origin main
```

## 5. Publicar no Vercel

1. Acesse https://vercel.com e clique em **Add New** → **Project**
2. Importe o repositório `pesquisa-nps-freitas`
3. Não precisa configurar build command nem framework — é um site estático (deixe em branco / "Other")
4. Clique em **Deploy**
5. Em poucos segundos você terá uma URL do tipo `pesquisa-nps-freitas.vercel.app` — teste o formulário nela antes de seguir

## 6. Apontar o domínio pesquisa.freitasconsultoriacontabil.com.br

1. No projeto do Vercel, vá em **Settings** → **Domains**
2. Digite `pesquisa.freitasconsultoriacontabil.com.br` e clique em **Add**
3. O Vercel vai mostrar um registro DNS do tipo **CNAME**, algo como:
   ```
   Tipo:  CNAME
   Nome:  pesquisa
   Valor: cname.vercel-dns.com
   ```
4. Acesse o painel onde o domínio `freitasconsultoriacontabil.com.br` está registrado (Registro.br, GoDaddy, etc.) e na área de **DNS / Zona DNS**, adicione esse registro CNAME exatamente como o Vercel mostrou
5. Aguarde a propagação (geralmente de alguns minutos até 24h)
6. Quando o Vercel mostrar "Valid Configuration" ao lado do domínio, está pronto

## 7. Testar

- Acesse `https://pesquisa.freitasconsultoriacontabil.com.br` e envie uma resposta de teste
- Clique em "acessar resultados (equipe)", digite o código e confira se a resposta aparece
- Pode apagar a resposta de teste depois direto no Supabase: **Table Editor** → `respostas_nps`

---

**Dúvidas comuns**

- *"Erro ao enviar" no formulário* → confira se `SUPABASE_URL` e `SUPABASE_ANON_KEY` foram colados corretamente, sem espaços extras
- *Resultados não carregam* → confira se o script `schema.sql` rodou sem erros no SQL Editor
- *Quer trocar a pergunta ou os campos depois* → é só editar o `index.html` e fazer novo `git push`; o Vercel republica automaticamente

-- Pesquisa NPS · Freitas Consultoria Contábil e Financeira
-- Execute este script inteiro no SQL Editor do Supabase (projeto novo)

create table if not exists respostas_nps (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  score smallint not null check (score >= 0 and score <= 10),
  nome text not null,
  empresa text not null,
  comentario text,
  dor text,
  melhorar text
);

-- Habilita Row Level Security
alter table respostas_nps enable row level security;

-- Permite que qualquer visitante (chave anônima) INSIRA uma resposta
-- (é assim que o formulário público consegue gravar sem login)
create policy "Permitir envio publico"
  on respostas_nps
  for insert
  to anon
  with check (true);

-- Permite que a chave anônima também LEIA as respostas
-- (necessário porque a tela de resultados roda no navegador, sem backend próprio;
--  a proteção de acesso é feita pela senha no próprio site, como já era no protótipo)
create policy "Permitir leitura publica"
  on respostas_nps
  for select
  to anon
  using (true);

-- Permite que a chave anônima também EXCLUA respostas
-- (necessário para o botão "Excluir resposta" no painel da equipe;
--  a proteção de acesso continua sendo a senha no próprio site)
create policy "Permitir exclusao publica"
  on respostas_nps
  for delete
  to anon
  using (true);

-- Índice para ordenar por data rapidamente
create index if not exists idx_respostas_nps_created_at
  on respostas_nps (created_at desc);

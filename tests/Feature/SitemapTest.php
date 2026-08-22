<?php

namespace Tests\Feature;

use Tests\TestCase;

class SitemapTest extends TestCase
{
    public function test_sitemap_xml_returns_valid_xml(): void
    {
        $response = $this->get('/sitemap.xml');

        $response->assertOk();
        $this->assertStringContainsString('application/xml', $response->headers->get('Content-Type'));
        $this->assertStringContainsString('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">', $response->getContent());
        $this->assertStringContainsString('/about', $response->getContent());
        $this->assertStringContainsString('/journals', $response->getContent());
    }
}

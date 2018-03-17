<?php

/**
 * @file
 * islandora-solr-teaser.tpl.php
 *
 * @TODO: needs documentation about file and variables
 */
?>

    <div class="islandora islandora-basic-collection-object islandora-basic-collection-list-item clearfix">
      <dl>
        <dt>
          <!-- Thumbnail -->
          <?php if (isset($values['PID'])): ?>
            <a href="<?php print $GLOBALS['base_url']; ?>/islandora/object/<?php print $values['PID']; ?>">
              <img src="/islandora/object/<?php print $values['PID']; ?>/datastream/TN/view" title="<?php print $values['fgs_label_s']; ?>" alt="<?php print $values['PID']; ?>"/>  <!-- @TODO MAM modification -->
            </a>
          <?php endif; ?>
        </dt>

        <!-- MAM...introduce a creators statement -->
        <dd class="collection-value" id="collection-view-teaser-creators">
          <?php if (isset($values['creators_statement'])): ?>
            <?php print filter_xss($values['creators_statement']); ?>
          <?php endif; ?>
        </dd>
        <!-- ...done with creators_statement -->

        <!-- Label or Title -->
        <dd class="collection-value" id="collection-view-teaser-title">
          <?php if (isset($values['title_link'])): ?>
            <?php print filter_xss($values['title_link']); ?>
          <?php endif; ?>
        </dd>

        <!-- MAM...If there is a mods_abstract_ms value, print it -->
        <?php if (isset($values['mods_abstract_ms'])): ?>
          <dd class="collection-value" id="collection-view-teaser-abstract">
            <?php print filter_xss($values['mods_abstract_ms']['0']); ?>
          </dd>
        <?php endif; ?>

        <!-- MAM...If there is NOT a mods_abstract_ms value, print the dc.description if it exists -->
        <?php if (!isset($values['mods_abstract_ms']) && isset($values['dc.description'])): ?>
          <dd class="collection-value" id="collection-view-teaser-dc-description">
            <?php print filter_xss($values['dc.description']['0']); ?>
          </dd>
        <?php endif; ?>

      </dl>
    </div>
